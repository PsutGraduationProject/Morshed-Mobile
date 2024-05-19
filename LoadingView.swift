import SwiftUI
import Lottie
//A struct view that is used whenever the app is waiting for a reply
//from Whisk server,it takes a loading message as a parameter to
//show below the progressView spinner
struct LoadingView: View {
    let loadingMessage: String
    var body: some View {
        
        NavigationView{
            VStack(spacing: 8) {
                LottieView(animation: .named("loading_lottie"))
                    .playing(loopMode: .loop)
                    .frame(height: 700, alignment: .center)
                    .offset(y:-80)
//                ProgressView()
//                    .progressViewStyle(.circular)
//                Text (loadingMessage)
            }
            .background(.clear)
            .onAppear{
                print("loading")
            }
        }
    }
}

var BlurView: some View {
    
        ZStack {
            Rectangle()
                .foregroundColor(Color.white.opacity(0.5))
//                .edgesIgnoringSafeArea(.all)
                
            
            
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottom)
           
//
            
        }
      //  .background(.white)
//        .ignoresSafeArea()
  
}



#Preview {
    LoadingView(loadingMessage: "loading")
}
