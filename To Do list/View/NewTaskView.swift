import SwiftUI

struct NewTaskView: View {
    
    @State var category: TaskCategory?
    @State var presentAlert = false
    
    @FocusState var focus: FocusField?
    
    /// View Properties
    @Environment(\.dismiss) private var dismiss
    /// Model Context For Saving Data
    @Environment(\.modelContext) private var context
    @State private var taskTitle: String = ""
    @Binding var taskDate: Date
    @State private var taskColor: String = "TaskColor 1"
    var body: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .tint(.red)
            })
            .hSpacing(.leading)
            .isHidden(focus != nil, remove: focus != nil)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text("Task Title")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                TextField("Add a task!", text: $taskTitle)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 15)
                    .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                    .focused($focus, equals: .taskField)
            })
            .padding(.top, 15)
            
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Task Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    DatePicker("", selection: $taskDate)
                        .datePickerStyle(.compact)
                        .scaleEffect(0.9, anchor: .leading)
                })
                /// Giving Some Space for tapping
                .padding(.trailing, -15)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Task Color")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    let colors: [String] = (1...5).compactMap { index -> String in
                        return "TaskColor \(index)"
                    }
                    
                    HStack(spacing: 0) {
                        ForEach(colors, id: \.self) { color in
                            Circle()
                                .fill(Color(color))
                                .frame(width: 20, height: 20)
                                .background(content: {
                                    Circle()
                                        .stroke(lineWidth: 2)
                                        .opacity(taskColor == color ? 1 : 0)
                                })
                                .hSpacing(.center)
                                .contentShape(.rect)
                                .onTapGesture {
                                    withAnimation(.snappy) {
                                        taskColor = color
                                    }
                                }
                        }
                    }
                })
                
            }
            .padding(.top,focus == nil ? 25 : 15)
           

           
            VStack(alignment:.leading, spacing: 4) {
                HStack {
                    Image(systemName: "tag")
                        .foregroundColor(.gray)
                        .frame(width: 30, height: 30, alignment: .leading)
                    
                    Text("Category")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    Text(category?.categoryName ?? "Select Category")
                        .foregroundColor(category?.categoryName == nil ? .gray : .black)
                    Spacer()
                }
                .padding(.top,focus == nil ? 25 : 15)
                CategoryView(selectedCategory: $category, categoryList: getCategoryList())
                    .padding(.top,focus == nil ? 10 : 5)
                    .padding(.bottom,focus == nil ? 25 : 15)
                    .padding(.horizontal,0)
            }
        
            Button(action: {
                guard let category = category else {
                    presentAlert = true
                    return
                }
                /// Saving Task
                let task = ToDoTask(taskTitle: taskTitle, creationDate: taskDate, tint: taskColor, category: category.categoryName)
                do {
                    context.insert(task)
                    try context.save()
                    /// After Successful Task Creation, Dismissing the View
                    dismiss()
                } catch {
                    print(error.localizedDescription)
                }
            }, label: {
                Text("Create Task")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
                    .foregroundStyle(.black)
                    .hSpacing(.center)
                    .padding(.vertical, 12)
                    .background(Color(taskColor).opacity(taskTitle == "" || category == nil ? 0.5 : 1), in: .rect(cornerRadius: 10))
            })
            
            .disabled(taskTitle == "" || category == nil)
            .opacity(taskTitle == "" ? 0.5 : 1)
        })
        .padding(.horizontal,15)
        .frame(maxHeight: .infinity,alignment: .bottom)
        .alert("Invalid", isPresented: $presentAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please select a Subject category")
        }
    }
}

enum FocusField: Hashable,CaseIterable {
    case taskField
}

