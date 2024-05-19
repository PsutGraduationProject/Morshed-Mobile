import SwiftUI

struct HomeButtonView: View {
    let title:String
    let image:Image
    let size: CGSize
    var body: some View {
        VStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.width, height: size.height)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 18)

            HStack { // Add a HStack to control the spacing
                Spacer()
                Text(title)
                    .multilineTextAlignment(.center)
                    .font(CustomFont.bold.font(size: 13))
                    .foregroundColor(Color(uiColor: .primary))
                    .fixedSize(horizontal: true, vertical: true)
                    .padding(.horizontal, 4) // Adjust the horizontal padding to your desired value
                Spacer()
            }
            .padding(.bottom, 19) // Move the bottom padding to the HStack
        }
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(red: 0.55, green: 0.55, blue: 0.55).opacity(0.13), lineWidth: 2)
        )
    }
}
