import SwiftUI
struct subjectCardView: View {
    let subject: Subject
    let color: Color
    var body: some View {
            ScheduleCardShape()
                .frame(height: 450)
                .cornerRadius(20)
                .foregroundColor(color)
                .overlay(alignment: .top) {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 45, height: 5, alignment: .center)
                }
            
                .overlay(alignment: .topLeading) {
                    VStack(alignment:.leading,spacing: 0) {
                        HStack {
                            VStack(alignment:.leading,spacing: 15){
                                Text("\(subject.courseNumber)")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(Color(hex:"333333",opacity: 0.5))
                                Text(subject.courseName)
                                    .font(.system(size: 26, weight: .bold))
                                    .minimumScaleFactor(0.9)
                                    .lineLimit(1)
                                    .foregroundStyle(.black)
                            }
                            Spacer()
                            VStack(alignment:.trailing,spacing: 15){
                                Text("expected grade")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(Color(hex:"333333",opacity: 0.5))
                                
                                Text("\(subject.courseGrade)%")
                                    .font(.system(size: 26, weight: .bold))
                                    .foregroundStyle(.black)
                            }
                        }
                        Text(subject.courseDescription)
                            .padding(.top,30)
                    }
                    .padding(.top,30)
                    .padding(.horizontal,20)
                }
    }
}

struct ScheduleCardShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.39538*width, y: 0.00016*height))
        path.addLine(to: CGPoint(x: 0, y: 0.00016*height))
        path.addLine(to: CGPoint(x: 0, y: 0.99984*height))
        path.addLine(to: CGPoint(x: width, y: 0.99984*height))
        path.addLine(to: CGPoint(x: width, y: 0.00016*height))
        path.addLine(to: CGPoint(x: 0.6051*width, y: 0.00016*height))
        path.addCurve(to: CGPoint(x: 0.50024*width, y: 0.0282*height), control1: CGPoint(x: 0.57973*width, y: 0.01882*height), control2: CGPoint(x: 0.54216*width, y: 0.0282*height))
        path.addCurve(to: CGPoint(x: 0.39538*width, y: 0.00016*height), control1: CGPoint(x: 0.45832*width, y: 0.0282*height), control2: CGPoint(x: 0.42076*width, y: 0.01882*height))
        path.closeSubpath()
        return path
    }
}
