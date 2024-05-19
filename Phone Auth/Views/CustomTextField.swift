import SwiftUI

struct CustomTextField: View {
    var hint: String
    @Binding var text: String
    // MARK: View Properties
    @FocusState var isEnabled: Bool
    var contentType: UITextContentType = .telephoneNumber
    var keyboardType: UIKeyboardType = .default
    var isSecure: Bool = false // Add an option to determine if the field is for passwords

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if isSecure {
                SecureField(hint, text: $text)
                    .keyboardType(keyboardType)
                    .textContentType(contentType)
                    .focused($isEnabled)
            } else {
                TextField(hint, text: $text)
                    .keyboardType(keyboardType)
                    .textContentType(contentType)
                    .focused($isEnabled)
            }

            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.black.opacity(0.2))
                Rectangle()
                    .fill(Color(hex: "3C5B6F"))
                    .frame(width: isEnabled ? nil : 0, alignment: .leading)
                    .animation(.easeInOut(duration: 0.3), value: isEnabled)
            }
            .frame(height: 2)
        }
    }
}
