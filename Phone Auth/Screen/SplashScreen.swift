import SwiftUI

struct SplashScreen: View {
    
    //local storage for login status and token
    @AppStorage("login_status") var login_status = false
    @AppStorage("token") var token = UUID().uuidString
    @AppStorage("studentID") var studentID = ""
    @StateObject var viewModel = PhoneAuthViewModel()
    @State var isTabBarHidden = false
    @State private var selectedIndex = 0 // Default to the first tab
    var body: some View {
        
        if login_status && !token.isEmpty {//Charity logged in
            UserTabBar(isTabBarHidden: $isTabBarHidden, selectedIndex: $selectedIndex, viewModel: viewModel)
        }
        
        else { 
            OnBoardingScreen( isTabBarHidden: $isTabBarHidden, selectedIndex: $selectedIndex)
        }
    }
}

#Preview {
    SplashScreen()
}

struct OnBoardingScreen: View {
    @Binding var isTabBarHidden: Bool
    @Binding var selectedIndex: Int
    @StateObject var viewModel = PhoneAuthViewModel()
    @State private var navigateToPhoneAuth = false  // State to control navigation
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Image("splash_screen")
                    .resizable()
                    .scaledToFill()
                NavigationLink(destination: PhoneAuthScreen(isTabBarHidden: $isTabBarHidden, selectedIndex: $selectedIndex , viewModel: viewModel), isActive: $navigateToPhoneAuth) {
                    EmptyView()
                }
                
                
                
                ButtonViewV3(buttonTitle: "Get Started", horizontalInnerPadding: 80, verticalInnerPadding: 20, cornerRadius: 9,linearGradient: LinearGradient(gradient: Gradient(colors: [Color(hex: "153448"), Color(hex: "153448")]), startPoint: .leading, endPoint: .trailing), titleFont: CustomFont.medium.font(.poppins, size: 20), function: {
                    navigateToPhoneAuth = true  // Triggers the NavigationLink
                })
                .padding(.bottom, 150)
                
            }
            .ignoresSafeArea()
            
        }
    }
}
