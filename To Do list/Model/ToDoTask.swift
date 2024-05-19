import SwiftUI
import SwiftData

@Model
class ToDoTask: Identifiable {
    var id: UUID
    var taskTitle: String
    var creationDate: Date
    var isCompleted: Bool
    var tint: String
    var category: String
    
    init(id: UUID = .init(), taskTitle: String, creationDate: Date = .init(), isCompleted: Bool = false, tint: String,category: String) {
        self.id = id
        self.taskTitle = taskTitle
        self.creationDate = creationDate
        self.isCompleted = isCompleted
        self.tint = tint
        self.category = category
    }
    
    var tintColor: Color {
        switch tint {
        case "TaskColor 1": return Color(hex: "#92C7CF")
        case "TaskColor 2": return Color(hex: "#FFBE98")
        case "TaskColor 3": return Color(hex: "#EEEEEE")
        case "TaskColor 4": return Color(hex: "#51829B")
        case "TaskColor 5": return Color(hex: "#D3CEBD")
        default: return .black
        }
    }
}

extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}


struct TaskCategory:Identifiable {
    var id:Int = 0
    var categoryName: String = ""
    var categoryImage: String = ""
    var color: Color
    var isSelected:Bool = false
}


func getCategoryList() -> [TaskCategory] {
    return [
        TaskCategory(id: 0, categoryName: "Algorithms", categoryImage: "function", color: .darkPastelYellow),
        TaskCategory(id: 1, categoryName: "Data Structures", categoryImage: "square.stack.3d.up.fill", color: .darkPastelOrange),
        TaskCategory(id: 2, categoryName: "Operating Systems", categoryImage: "internaldrive.fill", color: .darkPastelRed),
        TaskCategory(id: 3, categoryName: "Networking", categoryImage: "network", color: .darkPastelPurple),
        TaskCategory(id: 4, categoryName: "Database Systems", categoryImage: "externaldrive.connected.to.line.below.fill", color: .darkPastelBlue),
        TaskCategory(id: 5, categoryName: "Software Engineering", categoryImage: "hammer.fill", color: .darkPastelGreen),
        TaskCategory(id: 6, categoryName: "Human-Computer Interaction", categoryImage: "hand.tap.fill", color: .darkPastelPink),
        TaskCategory(id: 7, categoryName: "Web Development", categoryImage: "network.badge.shield.half.filled", color: .darkPastelMint),
        TaskCategory(id: 8, categoryName: "Machine Learning", categoryImage: "cpu.fill", color: .darkPastelCyan),
        TaskCategory(id: 9, categoryName: "Artificial Intelligence", categoryImage: "brain.head.profile", color: .darkPastelMagenta),
        TaskCategory(id: 10, categoryName: "Computer Graphics", categoryImage: "paintbrush.pointed.fill", color: .darkPastelTeal),
        TaskCategory(id: 11, categoryName: "Cybersecurity", categoryImage: "lock.shield.fill", color: .darkPastelLime),
        TaskCategory(id: 12, categoryName: "Quantum Computing", categoryImage: "q.circle.fill", color: .darkPastelViolet),
        TaskCategory(id: 13, categoryName: "Game Development", categoryImage: "gamecontroller.fill", color: .darkPastelGrey),
        TaskCategory(id: 14, categoryName: "Virtual Reality", categoryImage: "eyeglasses", color: .darkPastelSkyBlue),
        TaskCategory(id: 15, categoryName: "Cloud Computing", categoryImage: "cloud.fill", color: .darkPastelCream),
        TaskCategory(id: 16, categoryName: "Information Systems", categoryImage: "info.circle.fill", color: .darkPastelPeach),
        TaskCategory(id: 17, categoryName: "Embedded Systems", categoryImage: "memorychip.fill", color: .darkPastelRose),
        TaskCategory(id: 18, categoryName: "Cryptography", categoryImage: "lock.doc.fill", color: .darkPastelOlive),
        TaskCategory(id: 19, categoryName: "Computer Architecture", categoryImage: "building.columns.fill", color: .darkPastelLavender),
        TaskCategory(id: 20, categoryName: "Programming Languages", categoryImage: "character.cursor.ibeam", color: .darkPastelSage),
        TaskCategory(id: 21, categoryName: "Compiler Design", categoryImage: "curlybraces.square.fill", color: .darkPastelGold),
        TaskCategory(id: 22, categoryName: "Mobile Application Development", categoryImage: "iphone.homebutton", color: .darkPastelBurgundy),
        TaskCategory(id: 23, categoryName: "Data Science", categoryImage: "chart.xyaxis.line", color: .darkPastelNavy),
        TaskCategory(id: 24, categoryName: "Distributed Systems", categoryImage: "network.badge.shield.half.filled", color: .darkPastelChocolate)
    ]
}

extension Color {
    static let darkPastelYellow = Color(hex: "9E9FA5")
    static let darkPastelOrange = Color(red: 255/255, green: 179/255, blue: 71/255)
    static let darkPastelRed = Color(red: 255/255, green: 105/255, blue: 97/255)
    static let darkPastelPurple = Color(red: 149/255, green: 117/255, blue: 205/255)
    static let darkPastelBlue = Color(red: 0/255, green: 122/255, blue: 255/255)
    static let darkPastelGreen = Color(red: 0/255, green: 150/255, blue: 0/255)
    static let darkPastelPink = Color(red: 255/255, green: 182/255, blue: 193/255)
    static let darkPastelMint = Color(red: 62/255, green: 180/255, blue: 137/255)
    static let darkPastelCyan = Color(red: 0/255, green: 139/255, blue: 139/255)
    static let darkPastelMagenta = Color(red: 199/255, green: 21/255, blue: 133/255)
    static let darkPastelTeal = Color(red: 0/255, green: 128/255, blue: 128/255)
    static let darkPastelLime = Color(red: 50/255, green: 205/255, blue: 50/255)
    static let darkPastelViolet = Color(red: 138/255, green: 43/255, blue: 226/255)
    static let darkPastelGrey = Color(red: 169/255, green: 169/255, blue: 169/255)
    static let darkPastelSkyBlue = Color(red: 135/255, green: 206/255, blue: 235/255)
    static let darkPastelCream = Color(red: 222/255, green: 217/255, blue: 201/255)
    static let darkPastelPeach = Color(red: 255/255, green: 218/255, blue: 185/255)
    static let darkPastelRose = Color(red: 188/255, green: 143/255, blue: 143/255)
    static let darkPastelOlive = Color(red: 107/255, green: 142/255, blue: 35/255)
    static let darkPastelLavender = Color(red: 230/255, green: 230/255, blue: 250/255)
    static let darkPastelSage = Color(red: 188/255, green: 184/255, blue: 138/255)
    static let darkPastelGold = Color(red: 255/255, green: 215/255, blue: 0/255)
    static let darkPastelBurgundy = Color(red: 128/255, green: 0/255, blue: 32/255)
    static let darkPastelNavy = Color(red: 0/255, green: 0/255, blue: 128/255)
    static let darkPastelChocolate = Color(red: 210/255, green: 105/255, blue: 30/255)
}
