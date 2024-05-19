import Foundation

// Root response model for the OTP GraphQL operation
struct OTPGraphQLResponse: Codable {
    let data: OTPDataResponse
}

// Nested data model within the GraphQL response
struct OTPDataResponse: Codable {
    let generateOtp: OTPDetails?
    let verifyOtp: OTPDetails?
}


// Model for the OTP details received in the response
struct OTPDetails: Codable {
    var otp: Int?
    let message: String
    let success: Bool
}


