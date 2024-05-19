import SwiftUI
struct StudentHeaderView: View {
    let name: String
    let major: String
    let ID: String
    @State private var navigateToSplashScreen = false  // State to control navigation
    var body: some View {
        HStack(spacing: 0) {
            
            NavigationLink(destination: OnBoardingScreen(isTabBarHidden:.constant(false), selectedIndex: .constant(0), viewModel: PhoneAuthViewModel()) .navigationBarHidden(true)  
                .navigationBarBackButtonHidden(true), isActive:$navigateToSplashScreen) {Text("")}
            VStack(alignment:.leading,spacing: 4) {
                Text(name)
                    .font(CustomFont.medium.font(.poppins, size: 20))
                Text("\(firstCharactersOfWords(major) ?? "") | \(ID)")
                    .font(CustomFont.regular.font(.poppins, size: 14))
                    .opacity(0.6)
            }
            .foregroundStyle(Color(hex:"153448"))
            Spacer()
            Image("avatar")
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius:4)
                .contextMenu {
                    Button(action: {
                        //  logout functionality
                        print("Logging out...")
                        AppStorage("login_status").wrappedValue = false
                    }) {
                        Text("Logout")
                            .foregroundStyle(.red)
                    }
                }
             
        }
    }
    
    func firstCharactersOfWords(_ input: String) -> String? {
        // Split the input string into components separated by whitespaces
        let words = input.components(separatedBy: .whitespaces).filter { !$0.isEmpty }
        
        // Ensure there are exactly two words
        guard words.count == 2 else {
            print("The input should contain exactly two words.")
            return nil
        }
        
        // Get the first character of each word
        let firstChar1 = words[0].first ?? Character("")
        let firstChar2 = words[1].first ?? Character("")
        
        // Return the concatenated result
        return String([firstChar1, firstChar2])
    }

}
