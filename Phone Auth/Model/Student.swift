import Foundation
struct Student: Codable {
    var token: String?
    
    var username: String?
    var firstName, lastName, phoneNumber,studentMajor: String?
    var studentGpa: Float?
    var passedHours: Int?
    var registeredHours: Int?
    
    enum CodingKeys: String, CodingKey {
        case username
        case firstName
        case lastName
        case phoneNumber
        case studentMajor
        case studentGpa
        case passedHours
        case registeredHours
    }
}


struct StudentGraphQLResponse: Decodable {
    let data: StudentData
}

struct StudentData: Decodable {
    let morshedStudent: Student?
}

struct StudentDetails: Decodable {
    let username: String
    let firstName: String
    let studentGpa: Double
    let studentMajor: String
    let passedHours: Int
    let registeredHours: Int
}
