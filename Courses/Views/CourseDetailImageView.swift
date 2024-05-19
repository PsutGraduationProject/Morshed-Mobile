import SwiftUI

struct CourseDetailImageView: View {
    let detailImageName:String
    var body: some View {
        let maxHeight = 529.0
        
        AsyncImage(url: URL(string:"https://morshed.co/"+detailImageName)) { image in
                  image
                .resizable()
                .aspectRatio(0.71976967,contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(height: maxHeight)
                .clipShape( RoundCornerShape(corners: .bottomRight , radius: 32))
                .shadow(color: Color(red: 26/255, green: 31/255, blue: 69/255, opacity: 0.2), radius: 6, x: 0, y: 1)
                .offset(y: 0)
              } placeholder: {
                  Image("morshed_course_placeholder_detail")
                      .resizable()
                      .aspectRatio(0.71976967,contentMode: .fill)
                      .frame(maxWidth: .infinity)
                      .frame(height: maxHeight)
                      .clipShape( RoundCornerShape(corners: .bottomRight , radius: 32))
                      .shadow(color: Color(red: 26/255, green: 31/255, blue: 69/255, opacity: 0.2), radius: 6, x: 0, y: 1)
                      .offset(y: 0)
                  
              }
        
    }
}
struct CourseDetailImageShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.01188*height))
        path.addLine(to: CGPoint(x: width, y: 0.01188*height))
        path.addLine(to: CGPoint(x: width, y: 0.90736*height))
        path.addCurve(to: CGPoint(x: 0.91467*width, y: 0.98337*height), control1: CGPoint(x: width, y: 0.94934*height), control2: CGPoint(x: 0.96179*width, y: 0.98337*height))
        path.addLine(to: CGPoint(x: 0, y: 0.98337*height))
        path.addLine(to: CGPoint(x: 0, y: 0.01188*height))
        path.closeSubpath()
        return path
    }
}


