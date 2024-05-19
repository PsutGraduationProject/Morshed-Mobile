import Foundation
import SwiftUI
//A viewModel class responsible for authenticating user
//the PhoneAuthViewModel class uses PhoneAuthService class which communicates with Morshed server
//to save user's personal details such as Token and UserID
//like any other viewModel in this project
//it's also responsible for exposing data, handling user input, business logic and state management

@MainActor //To perform on main thread in order to update our UI
class PhoneAuthViewModel: ObservableObject {
    //MARK: Phone
    @Published var studentID: String = ""
    @Published var password: String = ""

    
    @Published var isLoading = false // for managing loading State for both token and otp generation
    @Published var isSmsLoading = false //for managing loading State for SMS
    
    @Published var student = Student(token: "")
    @Published var otpDetails = OTPDetails(message: "", success: false)
    @Published var otpField = "" {
        didSet {
            isSendDisabled = otpField.count < 6
            guard otpField.count <= 6,
                  otpField.last?.isNumber ?? true else {
                otpField = oldValue
                return
            }
        }
    }
    
    @Published var isTextFieldDisabled = false
    @Published var isSendDisabled = true
    
    
    enum ViewModelError: Error {
           case invalidURL
           case requestFailed(Error)
           case invalidResponse
           case decodingError(Error)
       }

       // Generic function to execute a GraphQL request
       func executeGraphQL<T: Decodable>(urlString: String, query: String, token: String, decodingType: T.Type) async throws -> T {
           guard let url = URL(string: urlString) else {
               throw ViewModelError.invalidURL
           }
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           request.addValue("JWT \(token)", forHTTPHeaderField: "Authorization") // Use provided JWT token
           request.httpBody = try? JSONEncoder().encode(["query": query])
           do {
               let (data, response) = try await URLSession.shared.data(for: request)
               guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                 throw ViewModelError.invalidResponse
               }

               return try JSONDecoder().decode(T.self, from: data)
           } catch {
               throw ViewModelError.decodingError(error)
           }
       }
    
    
    func authenticateStudent() async throws -> String {
        isLoading = true
           let urlString = "https://morshed.co/v1/graphql/"
           guard let url = URL(string: urlString) else {
               print("Error: Invalid URL")
               throw ViewModelError.invalidURL
           }
           print("URL created: \(url)")
           
           let mutationRequest = """
           mutation {
             tokenAuth(studentId: "\(studentID)", password: "\(password)") {
               token
             }
           }
           """
           
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           do {
               request.httpBody = try JSONSerialization.data(withJSONObject: ["query": mutationRequest], options: [])
               print("Request body set successfully")
           } catch {
               print("Error: Failed to serialize JSON - \(error)")
               throw ViewModelError.requestFailed(error)
           }
           
           do {
               print("Starting network request...")
               let (data, response) = try await URLSession.shared.data(for: request)
               guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                   print("Error: Invalid server response \(response)")
                   throw ViewModelError.invalidResponse
               }
               print("Received valid response from the server")
               
               do {
                   let result = try JSONDecoder().decode(GraphQLResponse.self, from: data)
                   if let token = result.data.tokenAuth?.token {
                       print("Token retrieved successfully: \(token)")
                       student.token = token
                       student.username = studentID
                       
                       return token
                   } else {
                       print("Error: Token not found in response")
                       throw ViewModelError.invalidResponse
                   }
               } catch {
                   print("Error: Failed to decode JSON - \(error)")
                   throw ViewModelError.requestFailed(error)
               }
           } catch {
               print("Error: Network request failed - \(error)")
               throw ViewModelError.requestFailed(error)
           }
       }
    
    
    
    
    
    
   

    
    // Specific function to request OTP generation
    func requestOTP(token: String) async throws -> OTPDetails {
        let urlString = "https://morshed.co/v1/graphql/"
        let mutation = """
        mutation {
            generateOtp {
                otp
                message
                success
            }
        }
        """
        
        let response: OTPGraphQLResponse = try await executeGraphQL(urlString: urlString, query: mutation, token: token, decodingType: OTPGraphQLResponse.self)
        guard let otpDetails = response.data.generateOtp else {
            throw URLError(.badServerResponse) // Replace with more appropriate error handling
        }
        isLoading = false
        return otpDetails
    }

    func verifyOTP() async throws -> OTPDetails {
        isSmsLoading = true
        let urlString = "https://morshed.co/v1/graphql/"
        let mutation = """
        mutation {
            verifyOtp(otp: \"\(otpField)\") {
                message
                success
            }
        }
        """

        let response: OTPGraphQLResponse = try await executeGraphQL(urlString: urlString, query: mutation, token: student.token!, decodingType: OTPGraphQLResponse.self)
        guard let otpDetails = response.data.verifyOtp else {
            throw URLError(.badServerResponse) // Replace with more appropriate error handling
        }
        self.otpDetails = otpDetails
        
        if otpDetails.success {
            AppStorage("login_status").wrappedValue = true// To keep user logged in
            AppStorage("token").wrappedValue = student.token // To call the APIs with JWT token
            AppStorage("studentID").wrappedValue = student.username // To call the APIs with studentID
        }
        else {
            throw URLError(.badServerResponse)
        }
        
        isSmsLoading = false
        return otpDetails
    }
}



