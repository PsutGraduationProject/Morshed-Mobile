import SwiftUI

struct ScheduleScreen: View {
    @ObservedObject var dashboardVM: DashboardViewModel
    @Binding var isTabBarHidden: Bool
    // MARK: Animation Properties
    @State var expandCards: Bool = false
    
    // MARK: Detail View Properties
    @State var currentSubject: Subject?
    @State var showDetailCard: Bool = false
    @Namespace var animation
        
    @Environment(\.presentationMode) var presentationMode

    let colors = [
        Color(hex:"A4EAF7"),
        Color(hex:"B3ABF9"),
        Color(hex:"E6F6AB"),
        Color(hex:"F3B2B0"),
        Color(hex:"ECECEC"),
        Color(hex:"92C7CF"),
        Color(hex:"F4F2DE")
    ]
    
    @State var subjects =  [Subject]()
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 0) {
                // Chevron back button
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward.circle")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 26, height: 26)
                        .foregroundColor(Color(hex:"4D60B0"))
                        .fontWeight(.semibold)
                }
                .frame(width: 30, alignment: .leading)
                // Text and other controls in an inner HStack
                HStack {
                    Spacer(minLength: 0)
                    Text("Schedule")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .padding(.horizontal,0)
                        .padding(.leading,2)
                        .frame(maxWidth: .infinity, alignment: expandCards ? .leading : .center)

                    Spacer(minLength: 0)  // Ensures text can move as needed

                    // Existing close button code, overlaying on trailing edge
                    Button {
                        withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)) {
                            expandCards = false
                        }
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(10)
                            .background(Color(hex:"4D60B0"), in: Circle())
                    }
                    .rotationEffect(.init(degrees: expandCards ? 45 : 0))
                    .offset(x: expandCards ? 10 : 15)
                    .opacity(expandCards ? 1 : 0)
                }
                .padding(.horizontal, 15)
            }
            .padding(.bottom, 10)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0){
                    // MARK: Cards
                    ForEach(Array(subjects.enumerated()),id: \.1.courseNumber){ (index,subject) in
                        CardView(subject: subject,color:colors[index])
                            .padding(.bottom,index == subjects.count - 1 ? 90 : 0)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.35)){
                                currentSubject = subject
                                showDetailCard = true
                            }
                        }
                    }
                }
                .overlay {
                    // To Avoid Scrolling
                    Rectangle()
                        .fill(.black.opacity(expandCards ? 0 : 0.01))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.35)){
                                expandCards = true
                            }
                        }
                }
                .padding(.top,expandCards ? 30 : 0)
            }
            .coordinateSpace(name: "SCROLL")
            .offset(y: expandCards ? 0 : 30)
            .redactShimmer(condition: dashboardVM.isSubjectsLoading)
            // MARK: Add Button
            Button {
                Task {
                do { subjects = try await dashboardVM.getRecommendedSchedule() }
                }
            } label: {
                Image(systemName: "arrow.clockwise")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color(hex:"4D60B0"),in: Circle())
            }
            .rotationEffect(.init(degrees: expandCards ? 180 : 0))
            // To Avoid Warning 0.01
            .scaleEffect(expandCards ? 0.01 : 1)
            .opacity(!expandCards ? 1 : 0)
            .frame(height: expandCards ? 0 : nil)
            .padding(.bottom,expandCards ? 0 : 30)
        }
        .disabled(dashboardVM.isSubjectsLoading)
        .task {
            subjects = Subject.getDummySubjects()
            Task {
            do { subjects = try await dashboardVM.getRecommendedSchedule() }
            }
        }
        .padding([.horizontal,.top])
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .onAppear {
            isTabBarHidden = true
        }
    }
    
    // MARK: Card View
    @ViewBuilder
    func CardView(subject: Subject,color: Color)->some View{
        GeometryReader{proxy in
            
            let rect = proxy.frame(in: .named("SCROLL"))
            // Let's display some Portion of each Card
            let offset = CGFloat(getIndex(subject: subject) * (expandCards ? 15 : 110))
            ZStack(alignment: .bottomLeading) {
                subjectCardView(subject: subject,color: color)
            }
            // Making it as a Stack
            .offset(y: expandCards ? offset : -rect.minY + offset)
        }
        // Max Size
        .frame(height: 200)
    }
    
    // Retreiving Index
    func getIndex(subject: Subject)->Int{
        return subjects.firstIndex { currentSubject in
            return currentSubject.courseNumber == subject.courseNumber
        } ?? 1
    }
}

// MARK: Hiding all Number except last four
// Global Method
func customisedCardNumber(number: String)->String{
    
    var newValue: String = ""
    let maxCount = number.count - 4
    
    number.enumerated().forEach { value in
        if value.offset >= maxCount{
            // Displaying Text
            let string = String(value.element)
            newValue.append(contentsOf: string)
        }
        else{
            // Simply Displaying Star
            // Avoiding Space
            let string = String(value.element)
            if string == " "{
                newValue.append(contentsOf: " ")
            }
            else{
                newValue.append(contentsOf: "*")
            }
        }
    }
    return newValue
}
