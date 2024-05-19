import SwiftUI

struct SMSVerificationScreen: View {
    @Binding var isTabBarHidden: Bool
    @Binding var selectedIndex: Int
    
    @ObservedObject var viewModel: PhoneAuthViewModel
    @FocusState var activeField:OTPField?
    
    
    @FocusState var isFocused:Bool
    @State var isPresented = true
    @State var presentAlert = false
    
    @State private var navigateToHomeScreen = false  // State to control navigation
    
    let textBoxWidth = UIScreen.main.bounds.width / 8
    let textBoxHeight = UIScreen.main.bounds.width / 8
    let spaceBetweenBoxes: CGFloat = 10
    let paddingOfBox: CGFloat = 1
    var textFieldOriginalWidth: CGFloat {
        (textBoxWidth*6)+(spaceBetweenBoxes*3)+((paddingOfBox*2)*3)
    }
    var body: some View {
        ZStack(alignment: .topLeading){
            Color.clear
            NavigationLink(destination: UserTabBar(isTabBarHidden: $isTabBarHidden, selectedIndex: $selectedIndex, viewModel: viewModel).navigationBarHidden(true)  // Hide the navigation bar
                .navigationBarBackButtonHidden(true), isActive: $navigateToHomeScreen) {
                    EmptyView()
                }
                .navigationBarHidden(true)  // Hide the navigation bar
                .navigationBarBackButtonHidden(true)
            VStack(spacing: 8){
                Text("Verification Code")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.custom("FiraSans-Medium", size: 35))
                Text("The verification code has been sent to your phone number")
                    .font(Font.custom("FiraSans-Medium", size: 16))
                    .padding(.leading,4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ZStack {
                    HStack (spacing: spaceBetweenBoxes){
                        ForEach(0..<6,id: \.self){ index in
                            OTPTextBox(index)
                        }
                    }
                    TextField("", text: $viewModel.otpField)
                        .frame(width: isFocused ? 0 : textFieldOriginalWidth, height: textBoxHeight)
                        .disabled(viewModel.isTextFieldDisabled)
                        .textContentType(.oneTimeCode)
                        .foregroundColor(.clear)
                        .accentColor(.clear)
                        .background(Color.clear)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                        .rotation3DEffect(Angle(degrees: 180 ), axis: (x: 0, y: 10, z: 0))
                }
                .padding(.top,UIScreen.screenHeight*0.2)
                
                
                //MARK: Verify OTP
                ButtonViewV3(buttonTitle: "Next", horizontalInnerPadding: 80, verticalInnerPadding: 20, cornerRadius: 9,linearGradient: LinearGradient(gradient: Gradient(colors: [Color(hex: "153448").opacity(viewModel.isSendDisabled ? 0.6 : 1), Color(hex: "153448").opacity(viewModel.isSendDisabled ? 0.6 : 1)]), startPoint: .leading, endPoint: .trailing), titleFont: CustomFont.medium.font(.poppins, size: 20), function: {
                    Task {
                        do {
                            let result = try await viewModel.verifyOTP()
                            
                            navigateToHomeScreen =  result.success
                            
                        }
                        catch {
                            presentAlert = true
                            viewModel.isSmsLoading = false
                            print("error")
                        }
                    }
                })
                .padding(.top,isFocused ? 20 : 100)
                .disabled(viewModel.isSendDisabled)
                .animation(.default)
                
            }
            .padding(.top,60)
            .padding(.horizontal,20)
        }
        .background(
            Image("SplashScreenBGV2")
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        )
        .onTapGesture { isFocused = false }
        .alert("Error", isPresented: $presentAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Invalid Code")
        }
        .overlay(
            ZStack {
                if viewModel.isLoading {
                    VStack {
                        ProgressView()
                        Text("loading")
                    }
                }
                else {
                    EmptyView()
                }
            }
        )
    }
    // MARK: OTP Text Box
    @ViewBuilder
    func OTPTextBox(_ index: Int)->some View{
        ZStack{
            if viewModel.otpField.count > index{
                // - Finding Char At Index
                let startIndex = viewModel.otpField.startIndex
                let charIndex = viewModel.otpField.index(startIndex, offsetBy: index)
                let charToString = String(viewModel.otpField[charIndex])
                Text(charToString)
            }
            else{
                Text ("")
            }
        }
        .frame (width: 45, height: 45)
        .background(
            
            VStack{
                //change color to status to change the animation
                // let status = (viewModel.otpField.count == index)
                let color = viewModel.otpField.count >= index+1
                Spacer()
                Rectangle()
                    .fill(color ? Color(hex:"333A73") : .gray.opacity(0.3))
                    .frame(height: 4)
            })
        .padding(paddingOfBox)
        // .frame(maxWidth: .infinity)
    }
}
//MARK: FocusState Enum
enum OTPField {
    case field1
    case field2
    case field3
    case field4
    case field5
    case field6
}



struct SMSVerificationScreen_Previews: PreviewProvider {
    static var previews: some View {
        SMSVerificationScreen(isTabBarHidden: .constant(false), selectedIndex: .constant(0), viewModel: PhoneAuthViewModel())
    }
}

