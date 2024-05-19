//import SwiftUI
//struct ErrorHandlerModifier: ViewModifier {
//    @Binding var error: NetworkError?
//
//    func body(content: Content) -> some View {
//        content
//            .alert(item: $error) { error in
//                Alert(
//                    title: Text("Error"),
//                    message: Text(error.localizedDescription),
//                    dismissButton: .default(Text("OK"))
//                )
//            }
//    }
//}
//
//extension View {
//    func handleError(_ error: Binding<NetworkError?>) -> some View {
//        modifier(ErrorHandlerModifier(error: error))
//    }
//}
//
