import Foundation
// Define the Course model
struct Course: Codable, Identifiable {
    var id = UUID() // Unique identifier for each course
    var courseName: String
    var courseDescription: String
    var courseImage: String
    var courseImageDetail: String
    var coursePrice: Float
    var courseProvider: String
    var courseLevel: String
    var courseUrl: String
    var numberOfHours: Int
    
    enum CodingKeys: CodingKey {
        case courseName
        case courseDescription
        case courseImage
        case courseImageDetail
        case coursePrice
        case courseProvider
        case courseLevel
        case courseUrl
        case numberOfHours
    }
}


struct CourseRecommendationResponse: Decodable {
    struct Data: Decodable {
        let courseRecommendation: [Course]
    }
    let data: Data
}


extension Course {
    static func getDummyCourses() -> [Course] {
        let courses = [
            
            Course(courseName: "SwiftUI Basics",
                   courseDescription: "Learn the fundamentals of SwiftUI to build beautiful and interactive iOS apps.",
                   courseImage: "swiftui-basics-thumbnail.jpg",
                   courseImageDetail: "swiftui-basics-detail.jpg",
                   coursePrice: 29.99,
                   courseProvider: "Apple Education",
                   courseLevel: "Beginner",
                   courseUrl: "https://example.com/swiftuibasics",
                   numberOfHours: 10),
            
            Course(courseName: "SwiftUI Basics",
                   courseDescription: "Learn the fundamentals of SwiftUI to build beautiful and interactive iOS apps.",
                   courseImage: "swiftui-basics-thumbnail.jpg",
                   courseImageDetail: "swiftui-basics-detail.jpg",
                   coursePrice: 29.99,
                   courseProvider: "Apple Education",
                   courseLevel: "Beginner",
                   courseUrl: "https://example.com/swiftuibasics",
                   numberOfHours: 10),
            
            Course(courseName: "SwiftUI Basics",
                   courseDescription: "Learn the fundamentals of SwiftUI to build beautiful and interactive iOS apps.",
                   courseImage: "swiftui-basics-thumbnail.jpg",
                   courseImageDetail: "swiftui-basics-detail.jpg",
                   coursePrice: 29.99,
                   courseProvider: "Apple Education",
                   courseLevel: "Beginner",
                   courseUrl: "https://example.com/swiftuibasics",
                   numberOfHours: 10),
            
            Course(courseName: "SwiftUI Basics",
                   courseDescription: "Learn the fundamentals of SwiftUI to build beautiful and interactive iOS apps.",
                   courseImage: "swiftui-basics-thumbnail.jpg",
                   courseImageDetail: "swiftui-basics-detail.jpg",
                   coursePrice: 29.99,
                   courseProvider: "Apple Education",
                   courseLevel: "Beginner",
                   courseUrl: "https://example.com/swiftuibasics",
                   numberOfHours: 10)
            
          ]
        
        return courses
    }
}
