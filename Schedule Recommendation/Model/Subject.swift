import SwiftUI
import Foundation
struct Subject: Hashable,Codable {
    let courseName: String
    let courseDescription: String
    let courseNumber: Int
    let courseGrade: String
   
    enum CodingKeys: String, CodingKey {
        case courseName
        case courseNumber
        case courseDescription
        case courseGrade
    }
}

struct ScheduleRecommendationResponse: Decodable {
    struct Data: Decodable {
        let scheduleRecommendation: [Subject]
    }
    let data: Data
}



extension Subject {
    static func getDummySubjects() -> [Subject] {
        let subjects: [Subject] = [
                Subject(courseName: "Introduction to CS", courseDescription: "Basics of programming using languages like Python and Java.", courseNumber: 101, courseGrade: "85"),
                Subject(courseName: "Data Structures", courseDescription: "Introduction to data structures such as arrays, lists, and trees.", courseNumber: 202, courseGrade: "88"),
                Subject(courseName: "Operating Systems", courseDescription: "Study of basic operating system functions including process management.", courseNumber: 303, courseGrade: "91"),
                Subject(courseName: "Database Systems", courseDescription: "Foundations of database concepts, SQL, and schema design.", courseNumber: 404, courseGrade: "87"),
                Subject(courseName: "Artificial Intelligence", courseDescription: "Overview of AI principles, including machine learning algorithms.", courseNumber: 505, courseGrade: "92")
            ]
        
        return subjects
    }
}
