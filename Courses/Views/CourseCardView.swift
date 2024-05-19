import SwiftUI
import SafariServices
struct CourseCardView: View {
    let course: Course
    var namespace: Namespace.ID
    var body: some View {
        let textAlignment:Alignment =  .topLeading
        let stackAlignment:HorizontalAlignment =  .leading
        VStack(alignment: stackAlignment, spacing: 0) {
            AsyncImage(url: URL(string: "https://morshed.co/"+course.courseImage)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 350, height: 147)
                    .matchedGeometryEffect(id: "image\(course.id)", in: namespace)
            } placeholder: {
                Image("morshed_course_placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 350, height: 147)
                    .matchedGeometryEffect(id: "image\(course.id)", in: namespace)
            }
            
            HStack {
                VStack(alignment: stackAlignment, spacing: 6) {
                    Text(course.courseName)
                        .font(CustomFont.bold.font(size: 22))
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer()
                    HStack(spacing:2){
                        Text("By")
                            .foregroundStyle(.gray)
                        Text(course.courseProvider)
                            .foregroundStyle(Color(hex:"#4D60B0"))
                        
                    }
                    .font(CustomFont.medium.font(size: 14))
                }
                Spacer()
                
                VStack(alignment: .trailing, spacing: 6) {
                    Text("$\(String(format: "%.0f", course.coursePrice))")
                        .foregroundStyle(Color(hex:"#4D60B0"))
                        .font(CustomFont.bold.font(size: 20))
                    
                    Spacer()
                    HStack(spacing: 2) {
                        Image(systemName: "clock.fill")
                            .renderingMode(.template)
                            .foregroundStyle(.black.opacity(0.6))
                        Text("\(course.numberOfHours) hours")
                            .foregroundStyle(.gray)
                            .font(CustomFont.medium.font(size: 14))
                    }
                }
            }
            .padding(.top,20)
            .padding(.bottom,10)
            .foregroundColor(Color(uiColor: .primary))
            .padding(.horizontal , 12)
            .frame(width: 350, height: 122,alignment: textAlignment)
            .multilineTextAlignment( .leading )
            
        }
        .frame(width: 350, height: 269,alignment: textAlignment)
        .rotation3DEffect(Angle(degrees:  0), axis: (x: 0, y: 0, z: 0))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
                .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: 2)
        )
        .padding(.top,15)
        .navigationBarBackButtonHidden()
    }
}




