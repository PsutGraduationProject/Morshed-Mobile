import SwiftUI
@main
struct MorshedApp: App {
    var body: some Scene {
        WindowGroup {            
         SplashScreen()
                .preferredColorScheme(.light)
        }
        .modelContainer(for: ToDoTask.self)
    }
}
enum UserTabItems: CaseIterable {
    case dashboard
    case home

    var itemIndex: Int {
        switch self {
        case .dashboard:
            return 0
        case .home:
            return 1
        }
    }

    var image: Image {
        switch self {
        case .dashboard:
            return Image(systemName: "house")
        case .home:
            return Image(systemName: "checklist.checked")
        }
    }

    var title: String {
        switch self {
        case .dashboard:
            return ""
        case .home:
            return ""
        }
    }
}
struct UserTabBar: View {

   
    @Binding var isTabBarHidden: Bool
    @Binding var selectedIndex: Int

    @ObservedObject var viewModel: PhoneAuthViewModel
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Group {
                switch selectedIndex {
                case 0:
                    DashboardScreen(vm: viewModel, isTabBarHidden: $isTabBarHidden, selectedIndex: $selectedIndex)
                case 1:
                    ToDoScreen(isTabBarHidden: $isTabBarHidden)
                default:
                    Text("Not Found")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            VStack {
                Spacer()
                HStack(spacing: 0) {
                    ForEach(UserTabItems.allCases, id: \.self) { item in
                        Button(action: {
                            self.selectedIndex = item.itemIndex
                        }) {
                            VStack {
                                item.image
                                    .font(.system(size: 25))
                                    .foregroundColor(selectedIndex == item.itemIndex ? Color(hex:"153448") : Color.gray)
                                Text(item.title)
                                    .font(.caption)
                                    .foregroundColor(selectedIndex == item.itemIndex ? Color(hex:"153448") : Color.gray)
                            }
                        }
                        .frame(maxWidth: .infinity) // This ensures each button takes equal space
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 15)
                .background(Color.white.shadow(radius: 2))
                .isHidden(isTabBarHidden, remove: isTabBarHidden)

            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
