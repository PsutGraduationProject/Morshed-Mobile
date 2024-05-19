import SwiftUI
struct CourseDetailScreen: View {
    let course: Course
    var namespace: Namespace.ID
    @Environment(\.presentationMode) var presentationMode
    @State private var showSafariView = false
    var body: some View {
            VStack(spacing: 5) {
                CourseDetailImageView(detailImageName: course.courseImageDetail)
                    .matchedGeometryEffect(id: "image\(course.id)", in: namespace)
                    .zIndex(1)
                    Group {
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(course.courseName)
                                    .font(CustomFont.bold.font(size: 14))
                                    .zIndex(1)
                                    .padding(.top,24)
                                    .lineLimit(2)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .matchedGeometryEffect(id: "title\(course.id)", in: namespace)
                                Spacer()
                                HStack(spacing:2){
                                    Text("By")
                                        .foregroundStyle(.gray)
                                    Text(course.courseProvider)
                                        .foregroundStyle(Color(hex:"#4D60B0"))
                                }
                                .font(CustomFont.medium.font(size: 14))
                                .matchedGeometryEffect(id: "courseSourceName\(course.id)", in: namespace)
                            }
                            
                        Spacer()
                            VStack(alignment: .trailing, spacing: 6) {
                                Text("$\(String(format: "%.0f", course.coursePrice))")
                                    .foregroundStyle(Color(hex:"#4D60B0"))
                                    .font(CustomFont.bold.font(size: 20))
                                    .padding(.top,24)
                                    .matchedGeometryEffect(id: "price\(course.id)", in: namespace)
                                Spacer()
                                HStack(spacing: 2) {
                                    Image(systemName: "clock.fill")
                                        .renderingMode(.template)
                                        .foregroundStyle(.black.opacity(0.6))
                                    Text("\(course.numberOfHours) hours")
                                        .foregroundStyle(.gray)
                                        .font(CustomFont.medium.font(size: 14))
                                }
                                .matchedGeometryEffect(id: "numberOfHours\(course.id)", in: namespace)
                                                           }
                        }
                        Text(course.courseDescription)
                            .font(CustomFont.medium.font(size: 16))
                            .padding(.trailing,10)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(nil)
                            .zIndex(1)
                            .padding(.top,15)
                        Spacer()
                    }
                    .padding(.horizontal,15)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .foregroundColor(Color(uiColor: .primary))
                Spacer()
                ButtonView(buttonTitle:"Subscribe",cornerRadius: 100, buttonColor: Color(hex:"153448"), titleColor: .white, titleAlignment: .center, titleFont:CustomFont.bold.font(size: 14) , function: { showSafariView = true })
                .frame(height: 48,alignment: .bottom)
                .padding(.horizontal,15)
            }
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
                  .navigationBarItems(leading: Button(action: {
                      self.presentationMode.wrappedValue.dismiss()
                  }) {
                      Image(systemName: "chevron.backward.circle")
                          .resizable()
                          .renderingMode(.template)
                          .frame(width: 26, height: 26)
                          .foregroundColor(Color(hex:"FEE8B0"))
                          .fontWeight(.semibold)
                  })
        .fullScreenCover(isPresented: $showSafariView) {
            SafariView(url: (URL(string:  course.courseUrl))!)
                    .edgesIgnoringSafeArea(.all)
        }
    }
}
