import SwiftUI

import SwiftUI
struct ButtonView: View {
  var buttonTitle:String = ""
  let isEnglish = false
  var width: CGFloat?
  var height: CGFloat?
  var cornerRadius: CGFloat?
  var buttonColor: Color?
  var titleColor: Color? = .white
  var titleAlignment: TextAlignment? = .leading
  var titleFont: Font = Font.custom("NeoSansArabic-Bold", size: 14 )
  var iconName: String?
    var iconColor: Color?
  var sfSymbolIconName: String?
  var borderColor: Color?
  var borderWidth: CGFloat?
  var function: () async -> Void
  var body: some View {
    Button(action: {
      Task{
        await function()
      }
    }) {
      HStack{
        if let iconName = iconName{
          Image(iconName)
                .renderingMode(iconColor != nil ? .template : .original)
                .foregroundColor(iconColor)
            
        }
        Text(buttonTitle)
          .foregroundColor(titleColor ?? .white)
          .font(titleFont)
          .multilineTextAlignment(titleAlignment ?? .center)
          .lineSpacing(5.25)
          .foregroundColor(Color.black)
          .isHidden(buttonTitle.isEmpty, remove: buttonTitle.isEmpty)
        if let sfSymbolIconName = sfSymbolIconName {
          Image(systemName: sfSymbolIconName)
            .resizable()
            .frame(width: 18, height: 18, alignment: .trailing)
            .scaleEffect(x: -1, y: 1)
            .foregroundColor(.white)
            .font(titleFont)
            .padding(.leading,2)
        }
      }
      .frame(maxWidth: width ?? .infinity,maxHeight: height ?? .infinity)
      .background(buttonColor ?? Color(uiColor: .fuschia_400))
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius ?? 9))
      .overlay(
        RoundedRectangle(cornerRadius: cornerRadius ?? 9)
          .stroke(borderColor ?? .clear, lineWidth: borderWidth ?? 1)
      )
    }
  }
}
struct RoundCornerShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
        
    }
    
}
