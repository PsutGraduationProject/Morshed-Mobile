import SwiftUI

struct DashboardScreen: View {
    @Namespace var namespace
    @ObservedObject var vm: PhoneAuthViewModel
    
    @StateObject var dashboardVM = DashboardViewModel()
    @Binding var isTabBarHidden: Bool
    @Binding var selectedIndex: Int
    var body: some View {
        NavigationView {
            
            ZStack {
                
                if dashboardVM.isLoading {
                    BlurView
                    LoadingView(loadingMessage: "loading")
                }
                else {
                    VStack(alignment: .leading,spacing: 0) {
                        StudentHeaderView(name: dashboardVM.student?.firstName ?? "" + (dashboardVM.student?.lastName ?? "")  , major: dashboardVM.student?.studentMajor ?? "", ID:  dashboardVM.student?.username ?? "")
                        
                        StatsWidgetView(gpa:dashboardVM.student?.studentGpa ?? 0 , tasksCount: dashboardVM.student?.registeredHours ?? 0,passedHours: dashboardVM.student?.passedHours ?? 0, totalHours: 132)
                            .padding(.top,25)
                            .frame(maxHeight: .infinity,alignment: .top)
                        Text("Tasks")
                            .font(CustomFont.medium.font(.poppins, size: 22))
                            .foregroundColor(Color(hex: "232946"))
                            .padding(.leading, 12)
                            .padding(.top,30)
                        ToDoListWidgetView(selectedIndex: $selectedIndex)
                            .padding(.top,15)
                            .frame(maxHeight: .infinity,alignment: .top)
                        //                Spacer()
                        Text("Recommendations")
                            .font(CustomFont.medium.font(.poppins, size: 22))
                            .foregroundColor(Color(hex: "232946"))
                            .padding(.leading, 12)
                        HStack(spacing: 10){
                            NavigationLink {
                                CoursesScreen(dashboardVM: dashboardVM,isTabBarHidden: $isTabBarHidden,
                                              namespace: namespace)
                                //                                                    .navigationBarHidden(true)
                                
                            } label: {
                                HomeButtonView(title: "Discover  Courses New\nSkills Beyond  Classroom", image: Image("courses"),size: CGSize(width: 120, height: 100))
                                
                            }
                            
                            NavigationLink{
                                ScheduleScreen(dashboardVM: dashboardVM, isTabBarHidden: $isTabBarHidden)
                                    .navigationBarHidden(true)
                            } label: {
                                HomeButtonView(title: "Organize Your Ideal\nCourse Schedule", image: Image("schedule"),size: CGSize(width: 120, height: 100))
                            }
                        }
                        .padding(.top,15)
                        .padding(.bottom,65)
                        
                    }
                    .onAppear {
                        isTabBarHidden = false
                    }
                    .padding(.horizontal,12)
                    
                }
            }
            .task {
                Task {
                    print(try await dashboardVM.requestStudentDetails())
                }
            }
        }
    }
}

#Preview {
    
    VStack(alignment: .leading, spacing: 0) {
        HStack {
            Text("Algorithms")
        }
        Text("Algorithms")
    }
}






