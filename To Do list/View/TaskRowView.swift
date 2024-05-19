import SwiftUI

struct TaskRowView: View {
    @Bindable var task: ToDoTask
    /// Model Context
    @Environment(\.modelContext) private var context
    /// Direct TextField Binding Making SwiftData to Crash, Hope it will be rectified in the Further Releases!
    /// Workaround use separate @State Variable
    @State private var taskTitle: String = ""
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Circle()
                .fill(indicatorColor)
                .frame(width: 10, height: 10)
                .padding(4)
                .background(.white.shadow(.drop(color: .black.opacity(0.1), radius: 3)), in: .circle)
                .overlay {
                    Circle()
                        .foregroundStyle(.clear)
                        .contentShape(.circle)
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                task.isCompleted.toggle()
                            }
                        }
                }
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text(task.category)
                    .font(CustomFont.regular.font(size: 14))
                TextField("Task Title", text: $taskTitle)
                    .font(CustomFont.bold.font(size: 24))
                    .foregroundStyle(.black)
                    .onSubmit {
                        /// If TaskTitle is Empty, Then Deleting the Task!
                        /// You can remove this feature, if you don't want to delete the Task even after the TextField is Empty
                        if taskTitle == "" {
                            context.delete(task)
                            try? context.save()
                        }
                    }
                    .onChange(of: taskTitle, initial: false) { oldValue, newValue in
                        task.taskTitle = newValue
                    }
                    .onAppear {
                        if taskTitle.isEmpty {
                            taskTitle = task.taskTitle
                        }
                    }

                
                
                HStack(spacing: 6) {
                    Image(systemName: "calendar")
                        .resizable()
                        .renderingMode(.template)
//                        .foregroundStyle()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 12, height: 12)
                    Text(task.creationDate.format("hh:mm a"))
                        .font(CustomFont.bold.font(size: 14))
                        .foregroundStyle(.black)
                }
                
              
                    
                
        
            })
            .padding(.vertical,20)
            .padding(.leading,12)
            .hSpacing(.leading)
            .background(task.tintColor, in: .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
            .strikethrough(task.isCompleted, pattern: .solid, color: .black)
            .contentShape(.contextMenuPreview, .rect(cornerRadius: 15))
            .contextMenu {
                Button("Delete Task", role: .destructive) {
                    /// Deleting Task
                    /// For Context Menu Animation to Finish
                    /// If this causes any Bug, Remove it!
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        context.delete(task)
                        try? context.save()
                    }
                }
            }
            .offset(y: -8)
            
//            .overlay(alignment: .trailing) {
//                TagView(title: task.category,
//                        foregroundColor: .white,
//                        fillColor: .red,
//                        borderColor:.clear,
//                        cornerRadius: 6)
//            }
        }
    }
    
    var indicatorColor: Color {
        if task.isCompleted {
            return Color(hex:"75A47F")
        }
        
        return task.creationDate.isSameHour ? Color(hex:"#4D60B0") : (task.creationDate.isPast ? Color(hex:"E97777") : Color(hex:"DAC0A3"))
    }
}

#Preview {
    ContentView()
}



/// New task Category selection view
struct CategoryView: View{
    
    @Binding var selectedCategory: TaskCategory?
  
    
        @Namespace private var namespace
    var categoryList: [TaskCategory] = getCategoryList()
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.fixed(35)), GridItem(.fixed(35)), GridItem(.fixed(35)), GridItem(.fixed(35))], spacing: 10) {
                ForEach(Array(categoryList.enumerated()), id: \.element.id) { index, cat in
                    VStack {
                        HStack {
                            Image(systemName: cat.categoryImage)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(cat.color)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            Text(cat.categoryName)
                                .font(.callout)
                                .fontWeight(.regular)
                            Spacer()
                        }
                        .overlay {
                            if selectedCategory?.categoryName == cat.categoryName {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.clear)
                                    .frame(width: 120, height: 30)
                                    .padding(1)
                                    .padding(.leading,4)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(cat.color, lineWidth: 3)
                                    )
                                    .matchedGeometryEffect(id: "selection", in: namespace)
                            }
                        }
                        .onTapGesture {
                            withAnimation {
                                selectedCategory = cat
                            }
                        }
                        .frame(width: 120, height: 30)
                    }
                    .padding(.leading, index == 0 ? 15 : 0)
                    .padding(.trailing, index == categoryList.count - 1 ? 15 : 0)
                }
            }
        }

    }
}


