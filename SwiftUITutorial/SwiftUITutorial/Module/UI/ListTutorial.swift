//
//  ListTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/29.
//

import SwiftUI

/*
 struct List<SelectionValue, Content> where SelectionValue : Hashable, Content : View
 List的初始换很重要，有两个泛型类型： SectionValue、Content


 */
struct ListTutorial: View {

    private let contents = [
        Content(title: "Red", color: .red),
        Content(title: "Blue", color: .blue),
        Content(title: "Brown", color: .brown),
        Content(title: "Cyan", color: .cyan),
        Content(title: "Gray", color: .gray),
        Content(title: "Indigo", color: .indigo),
        Content(title: "Teal", color: .teal),
    ]

    private let contentIdentifiers = [
        ContentIdentifier(title: "Red", color: .red),
        ContentIdentifier(title: "Blue", color: .blue),
        ContentIdentifier(title: "Brown", color: .brown),
        ContentIdentifier(title: "Cyan", color: .cyan),
        ContentIdentifier(title: "Gray", color: .gray),
        ContentIdentifier(title: "Indigo", color: .indigo),
        ContentIdentifier(title: "Teal", color: .teal),
    ]

    @State private var boundContents = [
        Content(title: "Red", color: .red),
        Content(title: "Blue", color: .blue),
        Content(title: "Brown", color: .brown),
        Content(title: "Cyan", color: .cyan),
        Content(title: "Gray", color: .gray),
        Content(title: "Indigo", color: .indigo),
        Content(title: "Teal", color: .teal),
    ]

    @State private var boundContentIdentifiers = [
        ContentIdentifier(title: "Red", color: .red),
        ContentIdentifier(title: "Blue", color: .blue),
        ContentIdentifier(title: "Brown", color: .brown),
        ContentIdentifier(title: "Cyan", color: .cyan),
        ContentIdentifier(title: "Gray", color: .gray),
        ContentIdentifier(title: "Indigo", color: .indigo),
        ContentIdentifier(title: "Teal", color: .teal),
    ]

    private let files: [FileNode] = [
        FileNode(name: "Documents", children: [
            FileNode(name: "Photos", children: [
                FileNode(name: "Vacation.jpg"),
                FileNode(name: "Birthday.jpg")
            ]),
            FileNode(name: "Recipes", children: [
                FileNode(name: "Pasta.txt"),
                FileNode(name: "Cake.txt")
            ])
        ]),
        FileNode(name: "Work", children: [
            FileNode(name: "Resume.docx"),
            FileNode(name: "Project.docx")
        ])
    ]

    @Environment(\.editMode) private var editMode

    // MARK: - system
    var body: some View {
        //list_arbitrary_content
        //list_from_range
        //list_date
        //list_identifiable_data
        //list_bound_identifiable_data
        //list_bound_data
        //list_hierarchical_data
        list_editable_data
    }
}

// MARK: - creating list with arbitrary content
extension ListTutorial {
    
    /*
     init(content:)
     */
    var list_arbitrary_content: some View {

        List {
            Text("Hello, world")
            Text(Date(), style: .offset)
            Text(Date(), style: .relative)
            Text(Date(), style: .timer)
            Text(Date(), style: .date)
            Text(Date(), style: .time)

            Text(Image(systemName: "square.and.arrow.up.fill"))

            Text(AttributedString(stringLiteral: "AttributedString"))
        }
    }
}

// MARK: - creating list from a range
extension ListTutorial {
    
    /*
     @MainActor
     init<RowContent>(
         _ data: Range<Int>,
         @ViewBuilder rowContent: @escaping (Int) -> RowContent
     ) where Content == ForEach<Range<Int>, Int, RowContent>, RowContent : View

     我们发现，这种方式创建，Content都是ForEarch类型
     */
    var list_from_range: some View {
        List(0 ..< 10) { index in
            Text("Item \(index)")
        }
    }
}

// MARK: - Listing date
extension ListTutorial {

    /*
     @MainActor
     init<Data, ID, RowContent>(
         _ data: Data,
         id: KeyPath<Data.Element, ID>,
         @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent
     ) where Content == ForEach<Data, ID, RowContent>, Data : RandomAccessCollection, ID : Hashable, RowContent : View
     注意带id的初始化
     */
    var list_date: some View {
        List(contents, id: \.title) { content in
            Text(content.title).foregroundStyle(content.color)
        }
    }

    struct Content {
        var title: String
        var color: Color
    }
}

// MARK: - Listing identifiable date
extension ListTutorial {

    /*
     @MainActor
     init<Data, RowContent>(
         _ data: Data,
         @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent
     ) where Content == ForEach<Data, Data.Element.ID, RowContent>, Data : RandomAccessCollection, RowContent : View, Data.Element : Identifiable

     注意没有Id的的时候，Data.Element: Identifiable
     */
    var list_identifiable_data: some View {
        List(contentIdentifiers) { content in
            Text(content.title).foregroundStyle(content.color)
        }
    }

    struct ContentIdentifier: Identifiable {
        let id = UUID()

        var title: String
        var color: Color
    }
}

// MARK: - Listing bound data
extension ListTutorial {

    /*
     @MainActor
     init<Data, ID, RowContent>(
         _ data: Binding<Data>,
         id: KeyPath<Data.Element, ID>,
         @ViewBuilder rowContent: @escaping (Binding<Data.Element>) -> RowContent
     ) where Content == ForEach<LazyMapSequence<Data.Indices, (Data.Index, ID)>, ID, RowContent>, Data : MutableCollection, Data : RandomAccessCollection, ID : Hashable, RowContent : View, Data.Index : Hashable

     通过Binding绑定数据的好处，我们可以动态修改数据，包括list数据，以及list里面没条内容的数据
     */
    var list_bound_identifiable_data: some View {
        VStack {
            List($boundContentIdentifiers) { boundContent in
                Text(boundContent.title.wrappedValue)
                    .foregroundStyle(boundContent.color.wrappedValue)
            }
            Button("Add") {
                boundContentIdentifiers.append(ContentIdentifier(title: "Mint", color: .mint))
            }
            Button("Remove") {
                boundContentIdentifiers.removeLast()
            }
        }
    }

    /*
     @MainActor
     init<Data, ID, RowContent>(
         _ data: Binding<Data>,
         id: KeyPath<Data.Element, ID>,
         @ViewBuilder rowContent: @escaping (Binding<Data.Element>) -> RowContent
     ) where Content == ForEach<LazyMapSequence<Data.Indices, (Data.Index, ID)>, ID, RowContent>, Data : MutableCollection, Data : RandomAccessCollection, ID : Hashable, RowContent : View, Data.Index : Hashable

     至于返回的Element是Binding，那么我们是可以改变其内容的。
     */
    var list_bound_data: some View {
        VStack {
            List($boundContents, id: \.title) { boundContent in
                TextField("TextFiled", text: boundContent.title)
                    .foregroundStyle(boundContent.color.wrappedValue)
            }

            Button("Add") {
                boundContents.append(Content(title: "Mint", color: .mint))
            }
            Button("Remove") {
                boundContents.removeLast()
            }
        }
    }
}

// MARK: - Listing hierarchical data
extension ListTutorial {

    /*
     @MainActor
     init<Data, ID, RowContent>(
         _ data: Data,
         id: KeyPath<Data.Element, ID>,
         children: KeyPath<Data.Element, Data?>,
         @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent
     ) where Content == OutlineGroup<Data, ID, RowContent, RowContent, DisclosureGroup<RowContent, OutlineSubgroupChildren>>, Data : RandomAccessCollection, ID : Hashable, RowContent : View

     它是OutlineGroup的一种用法，用于展示具有嵌套关系的数据，例如文件系统的目录和文件，或者任何其他树形结构的数据。这种初始化方式使得在SwiftUI中创建这种类型的列表变得非常简单和直观。
     参数解释
     data: 代表要展示的数据集合，它需要遵循RandomAccessCollection协议，以便可以高效地随机访问它的元素。
     id: 用于唯一标识每个数据元素的KeyPath。这对于SwiftUI跟踪和更新UI时识别每个元素是必须的。
     children: 指向自身类型的可选子集合的KeyPath，用于表示元素的层级关系。这允许OutlineGroup理解数据之间的父子关系，从而构建层次结构。
     rowContent: 一个闭包，为数据集合中的每个元素返回一个用于展示该元素的视图。这个闭包接收一个Data.Element类型的参数，代表当前的数据元素。
     */
    var list_hierarchical_data: some View {
        List(files, children: \.children) { fileNode in
            Text(fileNode.name)
        }
    }

    struct FileNode: Identifiable {
        var id = UUID()
        let name: String
        var children: [FileNode]? // 文件夹可以包含子文件（夹），文件则为nil
    }
}

// MARK: - Listing editable data
extension ListTutorial {

    /*
     同样需要区分场景，是否需要绑定Id等两种勤快
     */
    var list_editable_data: some View {
        VStack {
            List($boundContentIdentifiers, editActions: [.delete]) { content in
                Text(content.title.wrappedValue).foregroundStyle(content.color.wrappedValue)
                    .frame(height: 49)
                    .listRowInsets(.none)
                    .listRowSpacing(0.0)
            }
            .animation(.linear, value: editMode?.wrappedValue) // 给进入编辑模式一个动画，当传nil是关闭动画

            Button(action: {
                // 手动切换编辑模式
                editMode?.wrappedValue = editMode?.wrappedValue.isEditing ?? false ? .inactive : .active
            }) {
                // 根据当前编辑模式状态显示不同文本
                Text(editMode?.wrappedValue.isEditing ?? false ? "Done" : "Edit")
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
    }
}


#Preview {
    ListTutorial()
}
