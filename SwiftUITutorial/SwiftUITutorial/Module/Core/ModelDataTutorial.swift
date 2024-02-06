//
//  ModelDataTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/3.
//

import SwiftUI

/*
 protocol DynamicProperty
 An interface for a stored variable that updates an external property of a view.
 用于控制界面刷新的，里面有一个方法 func update()

 @frozen @propertyWrapper
 struct State<Value>: DynamicProperty
 */

struct ModelDataTutorial: View {
    /*
     为了source of thrue原理。保证数据只跟当前View绑定，不能外部修改。
     */
    @State private var count = 0

    @State private var books = [Book(), Book(), Book()]

    // 这里甚至可以用@State也会有效果。但是还是建议用@state，因为这样在保证数据真实来源有帮助
    @State private var book = Book()

    // @State、@StateObject都建议使用private，防止外部引用模型进行更改
    @StateObject private var bookObservable = BookObservableObject()

    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {
            let _ = print("-----body")
            Text("\(count)")
            Divider()
            Button("Add") {
                count += 1
            }
            NavigationLink("PushToSencond") {
                ModelDataChildView(count: $count)
            }

            Divider()
            Text("Book.isAvailable:\(book.isAvailable.description)")
            bindable2

            Divider()
            Text("BookObservable.isAvailable:\(bookObservable.isAvailable.description)")
            Button("ChangeBookObservable") {
                bookObservable.isAvailable.toggle()
            }
            observableObject

            Divider()
            MyInitializableView(name: book.isAvailable.description)
                .id(book.isAvailable.description)
        }
    }
}

// MARK: - Bindable
extension ModelDataTutorial {
    /*
     You don’t need to make a wholesale replacement of the ObservableObject protocol throughout your app. Instead, you can make changes incrementally. Start by changing one data model type to use the Observable() macro. Your app can mix data model types that use different observation systems. However, SwiftUI tracks changes differently based on the observation system that a data model type uses, Observable versus ObservableObject.
     You may notice slight behavioral differences in your app based on the tracking method. For instance, when tracking as Observable(), SwiftUI updates a view only when an observable property changes and the view’s body reads the property directly. The view doesn’t update when observable properties not read by body changes. In contrast, a view updates when any published property of an ObservableObject instance changes, even if the view doesn’t read the property that changes, when tracking as ObservableObject.

     简单来说：
     1、不需要大量使用ObservableObject
     2、ObservableObject如果试图没有读取@Published属性，但该属性发生变化，同样试图会更新。但是Observable不会

     从下面可以看出来，Bindable一般修饰AnyObject，即class
     extension Bindable where Value : AnyObject, Value : Observable {

         /// Creates a bindable object from an observable object.
         ///
         /// You should not call this initializer directly. Instead, declare a
         /// property with the `@Bindable` attribute, and provide an initial value.
         public init(wrappedValue: Value)

         /// Creates a bindable object from an observable object.
         ///
         /// This initializer is equivalent to ``init(wrappedValue:)``, but is more
         /// succinct when when creating bindable objects nested within other
         /// expressions. For example, you can use the initializer to create a
         /// bindable object inline with code that declares a view that takes a
         /// binding as a parameter:
         ///
         ///     struct TitleEditView: View {
         ///         @Environment(Book.self) private var book
         ///
         ///         var body: some View {
         ///             TextField("Title", text: Bindable(book).title)
         ///         }
         ///     }
         ///
         public init(_ wrappedValue: Value)

         /// Creates a bindable from the value of another bindable.
         public init(projectedValue: Bindable<Value>)
     }

     // 这个表示对于Bindable，我们可以通过keypath来访问，并且返回一个Binding类型
     subscript<Subject>(dynamicMember keyPath: ReferenceWritableKeyPath<Value, Subject>) -> Binding<Subject> { get }

     @Bindable var book: Book
     let bindingString = _book[keypath: \.title]
     比如这样获取到的Bindingable就是string

     */
    var bindable: some View {
        List(books) { book in
            @Bindable var book = book
            TextField("Title", text: $book.title)
        }
    }

    var bindable2: some View {
        NavigationLink("PushToBook") {
            ModelDataBookView(book: book)
        }
    }
}

// MARK: - ObservableObject
extension ModelDataTutorial {

    var observableObject: some View {
        NavigationLink("PushToBookObservable") {
            ModelDataBookObservable(book: bookObservable)
        }
    }
}

// MARK: - Environment
extension ModelDataTutorial {

    /*
     两种注入方式
     */
    // @Environment(Book.self) var book1
    // @Environment(\.book) var book2
    var environmentView: some View {

        Text("")
            .environment(book)
            .environment(\.book, book)
    }
}

extension EnvironmentValues {
    var book: Book {
        get { self[BookKey.self] }
        set { self[BookKey.self] = newValue }
    }
}

// MARK: - OnChangeOf
extension ModelDataTutorial {

    // You can use onChange to trigger a side effect as the result of a value changing, such as an Environment key or a Binding.
    var onChangeOfView: some View {
        Button("Change Count") {
            count += 1
        }
        .onChange(of: count) {
            // count change
            print("onChange of count", count)
        }
    }
}

// MARK: - OnRecevie
extension ModelDataTutorial {

    var onReceviceOfView: some View {
        Button("Change") {

        }
        .onReceive(bookObservable.$isAvailable, perform: { _ in
            print("onReceive of book available", bookObservable.isAvailable)
        })
    }
}

#Preview {
    ModelDataTutorial()
}

// MARK: - Bindable
@Observable
class Book: Identifiable {
    var id = UUID().uuidString
    var title = "Sample Book Title"
    var isAvailable = true
}

/*
 SwiftUI creates a new instance of the model object only once during the lifetime of the container that declares the state object. For example, SwiftUI doesn’t create a new instance if a view’s inputs change, but does create a new instance if the identity of a view changes. When published properties of the observable object change, SwiftUI updates any view that depends on those properties, like the Text view in the above example.
 */
class BookObservableObject: ObservableObject {
    @Published var title = "Sample Book Title"
    @Published var isAvailable = true
}

class DataModel: ObservableObject {

    @Published var name: String

    init(name: String) {
        self.name = name
    }
}

// MARK: - Binding
struct ModelDataChildView: View {
    
    @Binding var count: Int

    /*
     Binging主要关注其初始化

     然后有两个额外方法：
     func animation(_ animation: Animation? = .default) -> Binding<Value>
     func transaction(_ transaction: Transaction) -> Binding<Value>
     */
    // MARK: - system
    var body: some View {
        Text("\(count)")
        Button("AddCount") {
            count += 1
        }
    }
}

// MARK: - ModelDataBookView
struct ModelDataBookView: View {

    // Book如果是可监听的，共享时候是可以不用加@Bindable的、甚至可以不用@state
    var book: Book
    // @Bindable var book: Book

    // MARK: - system
    var body: some View {
        Text("\(book.title)::\(book.isAvailable.description)")
        Button("AddCount") {
            book.isAvailable.toggle()
        }
    }
}

struct ModelDataBookObservable: View {
    @ObservedObject var book: BookObservableObject

    // MARK: - system
    var body: some View {
        Text("\(book.title)::\(book.isAvailable.description)")
        Button("AddCount") {
            book.isAvailable.toggle()
        }
    }
}

struct MyInitializableView: View {
    @StateObject private var model: DataModel


    init(name: String) {
        // SwiftUI ensures that the following initialization uses the
        // closure only once during the lifetime of the view, so
        // later changes to the view's name input have no effect.
        // print("MyInitializableView init", name)
        _model = StateObject(wrappedValue: DataModel(name: name))
    }


    var body: some View {
        VStack {
            Text("Name: \(model.name)")
        }
    }
}
