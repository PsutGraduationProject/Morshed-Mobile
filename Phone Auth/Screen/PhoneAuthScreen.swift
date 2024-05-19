import SwiftUI
struct PhoneAuthScreen: View {
    @Binding var isTabBarHidden: Bool
    @Binding var selectedIndex: Int
    @FocusState var isFocused:Bool
    @FocusState var isFocused2:Bool
    @ObservedObject var viewModel: PhoneAuthViewModel
    @State var isPresented = true
    @State private var navigateToSMS = false
    @State var presentAlert = false
    var body: some View {
        ZStack(alignment: .top){
            NavigationLink(destination: SMSVerificationScreen(isTabBarHidden: $isTabBarHidden, selectedIndex: .constant(0), viewModel: viewModel), isActive: $navigateToSMS) {
                EmptyView()
            }
            Color.clear
            VStack(spacing: 0){
                VStack(alignment:.leading,spacing: 5){
                    Text("Sign In")
                        .font(Font.custom("FiraSans-Medium", size: 35))
                    Text("Enter your ID and password to receive a verification code")
                        .font(Font.custom("FiraSans-Medium", size: 16))
                        .padding(.leading, 4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top,10)
                
                .frame(maxWidth: .infinity, alignment: .leading)
                VStack(spacing: 0){
                    Image("PhoneAuthPerson3")
                        .resizable()
                        .scaledToFit()
                        .padding(.top,isFocused ? 30 : 60)
                        .animation(.easeIn(duration: 0.25),value: isFocused)
                }
                
                .ignoresSafeArea()
                .animation(.easeIn(duration: 0.25),value: isFocused)
                
                CustomTextField(hint: "20xxxxxx", text: $viewModel.studentID, isEnabled: _isFocused, contentType: .telephoneNumber,keyboardType: .numberPad)
                    .padding(.top,isFocused ? 20 : 100)
                    .animation(.easeIn(duration: 0.25),value: isFocused)
                CustomTextField(hint: "********", text: $viewModel.password, isEnabled: _isFocused2, contentType: .password,isSecure: true)
                    .padding(.top,isFocused ? 20 : 30)
                    .animation(.easeIn(duration: 0.25),value: isFocused)
                
                ButtonViewV3(buttonTitle: "Send Code", horizontalInnerPadding: 80, verticalInnerPadding: 20, cornerRadius: 9,linearGradient: LinearGradient(gradient: Gradient(colors: [Color(hex: "153448"), Color(hex: "153448")]), startPoint: .leading, endPoint: .trailing), titleFont: CustomFont.medium.font(.poppins, size: 20), function: {
                    Task {
                        do {
                            let token = try await viewModel.authenticateStudent()
                            let otp = try await viewModel.requestOTP(token: token)
                            UIApplication.shared.endEditing(true)
                            navigateToSMS = true
                        }
                        catch {
                            presentAlert = true
                            viewModel.isLoading = false
                        }
                    }
                })
                .foregroundColor(.white)
                .padding(.top,isFocused ? 15 : 80)
                .animation(.easeIn(duration: 0.25),value: isFocused)
            }
        }
        .overlay(
            ZStack {
                if viewModel.isLoading {
                    VStack {
                        ProgressView()
                        Text("loading")
                    }
                    .frame(width: 100,height: 100)
                    .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                    )
                }
                else {
                    EmptyView()
                }
            }
        )
        .padding(.horizontal,25)
        .background(
            Image("SplashScreenBGV2")
                .rotationEffect(Angle(degrees: 180))
                .animation(.easeIn(duration: 0.25),value: isFocused)
        )
        .onTapGesture { isFocused = false }
        .alert("Error", isPresented: $presentAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Invalid student ID or password")
        }
    }
}

struct PhoneAuthScreen_Previews: PreviewProvider {
    static var previews: some View {
        PhoneAuthScreen(isTabBarHidden: .constant(false), selectedIndex: .constant(0), viewModel: PhoneAuthViewModel())
        
    }
}


//Navy Blue: #003366 - Primary, provides depth and seriousness.
//Soft Sky: #87CEEB - For contrast against the dark navy, offers a refreshing, calm vibe.
//Slate Gray: #708090 - Neutral, supports text readability and subtle accents.
//Ivory White: #FFFFF0 - For background elements, enhances visibility and space.
//Rich Silver: #BFC1C2 - Metallic accent for a modern touch.


//948979
//3C5B6F
//153448
//DAC0A3


extension UIApplication {
    // Function to dismiss the keyboard by resigning the first responder
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}
