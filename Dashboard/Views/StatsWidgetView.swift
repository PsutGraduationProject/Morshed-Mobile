import SwiftUI

struct StatsWidgetView: View {
    var gpa: Float
    var tasksCount: Int
    var passedHours: Int
    var totalHours: Int
    var body: some View {
        HStack{
            SubRingView(color: Color(hex: "082A40"), title: "GPA", value: String(format: "%.1f", gpa))
                .foregroundColor(.white)
                .padding(.top,64)
                .padding(.bottom,16)
                .frame(maxWidth: .infinity)

            MainRingView(progressFillColor: Color(hex:"FEE8B0"), progressEmptyColor: Color(hex:"082A40"), fillColor: Color(hex:"333A73"), currentValue: CGFloat(passedHours), goalValue: 132)
                .padding(.top,0)
            
            SubRingView(color: Color(hex: "082A40"), title: "Registered Hours", value:"\(tasksCount)")
                .foregroundColor(.white)
                .padding(.top,64)
                .padding(.bottom,16)
                .frame(maxWidth: .infinity)
        }
        .background(RoundedRectangle(cornerRadius: 20).fill(Color(hex:"3C5B6F")))
        
    }
}
