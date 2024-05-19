import SwiftUI
struct SubRingView: View {
    let color:Color
    let title:String
    let value: String
  
    var body: some View {
        VStack(spacing: 5){
            HStack(spacing: 1){
                Text(title)
            }
            .lineLimit(1)
            .font(CustomFont.bold.font(size: 11))
            Text(value)
                .font(CustomFont.bold.font(size: 20))
                .frame(width: 61,height: 61)
                .background(Circle().fill(color))
        }
        .foregroundColor(.white)
    }
}
