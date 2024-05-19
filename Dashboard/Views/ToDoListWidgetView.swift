import SwiftUI
import SwiftData
struct ToDoListWidgetView: View {
    @Query private var tasks: [ToDoTask]
    @Environment(\.modelContext) private var context
    @Binding var selectedIndex: Int

    init(selectedIndex: Binding<Int>) {
          let calendar = Calendar.current
          let today = calendar.startOfDay(for: Date())
          let endOfToday = calendar.date(byAdding: .day, value: 1, to: today)!

          let predicate = #Predicate<ToDoTask> {
              $0.creationDate >= today && $0.creationDate < endOfToday
          }
          let sortDescriptors = [
              SortDescriptor(\ToDoTask.creationDate, order: .forward)
          ]
          
          self._tasks = Query(filter: predicate, sort: sortDescriptors, animation: .default)
        
        self._selectedIndex = selectedIndex
      }
    
    let rows = [
        GridItem(.fixed(35)),
        GridItem(.fixed(35))
    ]
    let loadingCondition = false
    private let horizontalPadding: CGFloat = 24
    var body: some View {
        Group {
            if tasks.count > 0 || (loadingCondition) {
                LazyHGrid(rows: rows, alignment: .top, spacing: 20) {
//                    let items = ToDoTask.dummyTasks(count: 4)
                        ForEach(Array(zip(tasks.prefix(4).indices, tasks.prefix(4))) , id: \.1.id) { num,item in
                            ToDoItemCardView(item: item, action: {
//                                await vm.tickItemInHome(itemId: item.id)
                                
                                item.isCompleted.toggle()
                            })
                                .padding(.trailing,17)
                        }
                
                    

                }
                .frame(height: 100)
                .padding(.top,18)
                .padding(.bottom, 10)
            }
            else {
              
                VStack(spacing: 25){
//                    Text("Your day is clear—add a new task!")
                    Text("Empty day? Fill it with a new task!")
                        .foregroundStyle(Color(hex:"5F5F5F"))
                        .font(CustomFont.regular.font(size: 16))
                       
                    ButtonViewV3(buttonTitle: "Add Item", horizontalInnerPadding: 20, verticalInnerPadding: 6, cornerRadius: 31,linearGradient: LinearGradient(gradient: Gradient(colors: [Color(hex: "333A73"), Color(hex: "3B7194")]), startPoint: .leading, endPoint: .trailing), titleFont: CustomFont.medium.font(.poppins, size: 15), function: { selectedIndex = 1 })
                }
                .frame(maxWidth:.infinity, alignment: .center)
                .frame(height: 100)
                .padding(.top,18)
                .padding(.bottom, 10)
            }
                              
            
        }
        
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, horizontalPadding )
        .background(
            RoundedRectangle(cornerRadius: 9)
                .stroke(Color(hex: "D9D9D9",opacity: 0.35),lineWidth: 2)
                .shadow(color: Color.black.opacity(0.15), radius: 12, x: 0, y: 0)
                .foregroundStyle(.white)
            
        )
    }
}

//#Preview {
//    ToDoListWidgetView()
//}
struct ToDoItemCardView: View {
    
    var item: ToDoTask
//    @ObservedObject var shoppingListVM: ShoppingListViewModel
    let action: () async -> Void
    

    var body: some View {
        ZStack(alignment: .leading) {
            //Capsule shape
            HStack {
                VStack (alignment: .leading){
                    Text(item.taskTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(hex:"#153448"))
                        .font(.system(size: 10))
                        .offset(x:7)
                        .frame(width: 55, alignment: .leading) //freaking yesssss (to fix the position of text regardless of letter count)
                }
            }
            .frame(width: 94, height: 22)
            .background(Color(hex:"7F5283",opacity: 0.08))
            .clipShape(Capsule())
            //Checkmark shape
            ZStack{
                Circle()
                    .fill(item.isCompleted ? Color(hex: "DAC0A3") : .white)
                    .frame(width: 28, height: 28)
                    .onTapGesture{
                        print("item id is \(item.id)")
                        Task {await action()}
                    }
                    .overlay(
                        Circle()
                            .stroke(Color(hex: "DAC0A3"), lineWidth: 2)
                    )
                
                if item.isCompleted {
                    Image("Tick")
                        .foregroundColor(.white)
                        .font(.system(size:13))
                }
            }
            .offset(x:-10)
        }
    }
}
struct ButtonViewV3: View {
    
    var buttonTitle:String = ""
    var horizontalInnerPadding: CGFloat?
    var verticalInnerPadding: CGFloat?
    var cornerRadius: CGFloat?
    var buttonColor: Color?
    var linearGradient: LinearGradient? // New optional LinearGradient parameter
    var titleColor: Color? = .white
    var titleAlignment: TextAlignment? = .leading
    var titleFont: Font = Font.custom("NeoSansArabic-Bold", size: 14 )
    var iconName: String?
    var iconColor: Color?
    var sfSymbolIconName: String?
    var borderColor: Color?
    var borderWidth: CGFloat?
    var function: () async -> Void

    var body: some View {
        let solidGradient = LinearGradient(colors: [buttonColor ?? .red], startPoint: .leading, endPoint: .trailing)
        Button(action: {
            Task {
                await function()
            }
        }) {
            HStack {
                if let iconName = iconName{
                    Image(iconName)
                        .renderingMode(iconColor != nil ? .template : .original)
                        .foregroundColor(iconColor)
                }
                Text(buttonTitle)
                    .foregroundColor(titleColor ?? .white)
                    .font(titleFont)
                    .multilineTextAlignment(titleAlignment ?? .center)
                    .lineSpacing(5.25)
                    .foregroundColor(Color.black)
                    .isHidden(buttonTitle.isEmpty, remove: buttonTitle.isEmpty)
                if let sfSymbolIconName = sfSymbolIconName {
                    Image(systemName: sfSymbolIconName)
                        .resizable()
                        .frame(width: 12, height: 12, alignment: .trailing)
                        .foregroundColor(.white)
                        .font(titleFont)
                        .padding(.leading,4)
                }
            }
            .padding(.horizontal,horizontalInnerPadding)
            .padding(.vertical,verticalInnerPadding)

            .background(linearGradient ?? solidGradient)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius ?? 9))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius ?? 9)
                    .stroke(borderColor ?? .clear, lineWidth: borderWidth ?? 1)
            )
        }
    }
}
