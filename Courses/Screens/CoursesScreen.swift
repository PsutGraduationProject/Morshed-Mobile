import SwiftUI
struct CoursesScreen: View {
    @ObservedObject var dashboardVM: DashboardViewModel
    @Binding var isTabBarHidden: Bool
    @Environment(\.presentationMode) var presentationMode
    var namespace: Namespace.ID
    @State var courses = Course.getDummyCourses()
    @State private var expandCards: Bool = false  // Assuming you use this for expanding card details

    var body: some View {
        VStack(spacing: 0) {
            // Custom Navigation Bar
            HStack(spacing: 0) {
                // Chevron back button
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward.circle")
                        .resizable()
                        .renderingMode(.template)
//                        .aspectRatio(contentMode: .fit)
                        .frame(width: 26, height: 26)
                        .foregroundColor(Color(hex:"4D60B0")) // Set the color as desired
                        .fontWeight(.semibold)
                }
                .frame(width: 20, alignment: .leading)  // Ensures button has ample clickable area

//                Spacer()

                // Page title
                Text("Courses")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(Color(hex:"153448"))
//                Spacer()

            
            }
            .padding()
            .background(Color(.systemBackground))  // Adjust background color

            // Content of the screen
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(courses) { course in
                        NavigationLink(destination: CourseDetailScreen(course: course, namespace: namespace)) {
                            CourseCardView(course: course, namespace: namespace)
                                .redactShimmer(condition: dashboardVM.isCoursesLoading)
                                .padding(.vertical, 20)  // Increases vertical spacing around each card

                        }
                    }
                }
            }
            .disabled(dashboardVM.isCoursesLoading)
            .onAppear {
                isTabBarHidden = true
            }
        }
        
        .task {
            Task {
                dashboardVM.isCoursesLoading = true
            do { courses = try await dashboardVM.getRecommendedCourses() }
              
                // Delay execution for 4 seconds
                try await Task.sleep(nanoseconds: 4_000_000_000)
                dashboardVM.isCoursesLoading = false
            }
        }
    }
}
