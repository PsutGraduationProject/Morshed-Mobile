import SwiftUI

struct MainRingView: View {
    let progressFillColor:Color
    let progressEmptyColor:Color
    let fillColor:Color
    let currentValue:CGFloat
    let goalValue:CGFloat 
    var body: some View {
        ZStack {
            //each 2 px border is 4 width and height
            Circle()//empty border space
                .stroke(progressEmptyColor, lineWidth: 12)
                .frame(width: (UIScreen.main.bounds.width - 84) / 3, height: (UIScreen.main.bounds.width - 84) / 3)
            
            Circle() // filled border
                .trim(from: 0, to: (currentValue / goalValue))
                .stroke(progressFillColor, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                .frame(width: (UIScreen.main.bounds.width - 84) / 3, height: (UIScreen.main.bounds.width - 84) / 3)
                .rotationEffect(.degrees(-90))
            
            Circle()//fill color
                .fill(fillColor)
                .frame(width: (UIScreen.main.bounds.width - 84) / 3 - 12, height: (UIScreen.main.bounds.width - 84) / 3 - 12)
            
            
            VStack(spacing: 0){
                Text(String(format: "%.0f", currentValue))
                    .font(CustomFont.bold.font(size: 35))
                    .foregroundColor(.white)
                Text("Hours")
                    .font(CustomFont.bold.font(size: 16))
                    .foregroundColor(.white)
                    .padding(.top,-4)
                
            }
            
        }
    }
}
