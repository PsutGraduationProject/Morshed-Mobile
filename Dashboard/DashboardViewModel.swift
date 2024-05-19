import Foundation
import SwiftUI
@MainActor //To perform on main thread in order to update our UI
class DashboardViewModel: ObservableObject {
    
    @AppStorage("login_status") var login_status = false
    @AppStorage("token") var token = UUID().uuidString
    @AppStorage("studentID") var studentID = ""
    
    
    @Published var isLoading = true
    @Published var isCoursesLoading = true
    @Published var isSubjectsLoading = true
    @Published var student: Student?
    
   // Error type for GraphQL errors
    enum ViewModelError: Error {
           case invalidURL
           case requestFailed(Error)
           case invalidResponse
           case decodingError(Error)
       }

       // Generic function to execute GraphQL requests
       func executeGraphQL<T: Decodable>(urlString: String, query: String, token: String, decodingType: T.Type) async throws -> T {
           guard let url = URL(string: urlString) else { throw ViewModelError.invalidURL }

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
    
    // Function to request details of a student by ID, including debug print statements for tracing
    func requestStudentDetails() async throws -> Student {
        isLoading = true
        let urlString = "https://morshed.co/v1/graphql/"
        let query = """
        query {
            morshedStudent(studentId: \(studentID)) {
                username
                firstName
                studentGpa
                studentMajor
                passedHours
                registeredHours
            }
        }
        """

        // Debug print the constructed query and URL
        print("Executing GraphQL request at URL: \(urlString)")
        print("Query: \(query)")
        print("Using token: \(token)")

        // Delay execution for 2 seconds
        try await Task.sleep(nanoseconds: 4_000_000_000)

        do {
            let response: StudentGraphQLResponse = try await executeGraphQL(
                urlString: urlString,
                query: query,
                token: token,
                decodingType: StudentGraphQLResponse.self
            )

            // Debug print the raw response (be cautious with sensitive data in production)
            print("Received GraphQL response: \(response)")

            guard let studentDetails = response.data.morshedStudent else {
                print("Error: No student details found in the response.")
                throw URLError(.badServerResponse) // Replace with more appropriate error handling
            }

            // Debug print the student details fetched
            print("Fetched student details successfully: \(studentDetails)")
            isLoading = false
            student = studentDetails
            return studentDetails
        } catch {
            // Print the error and rethrow it
            print("Failed to fetch student details due to error: \(error)")
            isLoading = false
            throw error
        }
    }


    // A function that calls a GraphQL Query to request a list of recommended subjects
    func getRecommendedSchedule() async throws -> [Subject] {
        isSubjectsLoading = true // A state to show skelton loading while the API is getting called
        let urlString = "https://morshed.co/v1/graphql/"
        let query = """
        query {
            scheduleRecommendation(studentId: \(studentID)) {
                courseGrade
                courseName
                courseNumber
                courseDescription
            }
        }
        """
        
        do {
            let response: ScheduleRecommendationResponse? = try await executeGraphQL(
                urlString: urlString,
                query: query,
                token: token,
                decodingType: ScheduleRecommendationResponse.self
            )
            // Unwrap the response and check that is not null before returning it to be used in the Schedule screen
            guard let courses = response?.data.scheduleRecommendation, !courses.isEmpty else {
                print("Error: No course recommendations found in the response.")
                throw ViewModelError.invalidResponse
            }
            // Delay execution for 2 seconds for better user experience for loading purposes
            try await Task.sleep(nanoseconds: 2_000_000_000)
            isSubjectsLoading = false
                return courses
            } catch {
            print("Failed to fetch course recommendations due to error: \(error)")
            isSubjectsLoading = false
            throw error
        }
    }
    
    
    // Function to fetch recommended courses for a student
    func getRecommendedCourses() async throws -> [Course] {
        let urlString = "https://morshed.co/v1/graphql/"
        let query = """
        query{
          courseRecommendation(studentId: \(studentID)){
            courseName
            courseImage
            courseImageDetail
            coursePrice
            courseLevel
            courseProvider
            courseDescription
            courseUrl
            numberOfHours
          }
        }
        """
        
       

        // Debug print the constructed query
        print("Executing GraphQL request for recommended courses.")
        print("Query: \(query)")

        // Use the generic GraphQL execution function
        do {
            let response: CourseRecommendationResponse = try await executeGraphQL(
                urlString: urlString,
                query: query,
                token: token,
                decodingType: CourseRecommendationResponse.self
            )

            // Debug print the fetched courses
            print("Fetched course recommendations successfully.")
            for course in response.data.courseRecommendation {
                print("Course Name: \(course.courseName), Provider: \(course.courseProvider)")
            }
   
            return response.data.courseRecommendation
        } catch {
            print("Failed to fetch course recommendations due to error: \(error)")
            throw error
        }
    }
}
