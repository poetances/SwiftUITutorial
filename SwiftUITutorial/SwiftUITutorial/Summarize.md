
import SwiftUI

##所以一般Property、@State、@Binding一般修饰的都是View内部的数据。
##@ObservedObject、@EnvironmentObject都是修饰View外部的数据：
##    比如本地数据、网络数据等。


@propertyWrapper @frozen public struct ObservedObject<ObjectType> : DynamicProperty where ObjectType : ObservableObject { }

@frozen @propertyWrapper public struct EnvironmentObject<ObjectType> : DynamicProperty where ObjectType : ObservableObject { }

public protocol ObservableObject : AnyObject {}

#####
在SwiftUI中构建一个View的结构体实例只是短暂的存在，当View被渲染到屏幕上后，这个结构体实例就会被销毁。

当我们用State来标记一个属性时，SwiftUI会接管这个属性的storage。上面提到，SwiftUI中views是短暂存在的，当它们完成渲染后就会销毁，但是当我们标记其中的属性为State时，SwiftUI会维护这个属性，当属性发生改变时，SwiftUI会重新生成对应的view实例，然后根据这个属性值再次渲染。

7、SceneStore和AppStore。
    AppStore属性包装器，通过UserDefault来进行存储。
    @AppStorage("emailAddress") var emailAddress: String = "sample@email.com"
    // 这句话的意思，通过UserDefaults.standard.string(forKey: "emailAddress")来获取值，
    如果有就取值，就将值赋给emaailAddress变量，如果没有就给默认值“sample@email.com”

    
    类似
    @State var emailAddress: String = "sample@email.com" {
    get {
        UserDefaults.standard.string(forKey: "emailAddress")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "emailAddress")
    }
}

7、Swift package manager。即SPM的使用。通过SPM来替代cocoapod进行package管理。
    这里肯定有个问题，就是去github上面拉取资源，但是实际上，xocode是不能使用代理的，这样
    就会导致updating package会特别慢。
    
8、关于静态库和动态库。静态库有.a  .framework。 动态库有.tylb  .framework。
    区别静态库加载和执行速度更快。
    动态库更加节省资源。
    静态库在编译时加载，动态库在运行时加载。
    
    import和include其实就是将.h头文件的内容拷贝一份到当前文件中。
    
    在使用方面，如果是静态库，直接将代码拖入项目中就可以使用。
    如果是动态库，必须要将framework进行配置，即添加到Framework、libary和embedded content里面才能使用。
    
.a文件：是一个静态库文件，是目标文件.o的集合，经过链接可生成可执行文件。
.dylib文件：是一个动态库文件。
.framework文件：Framework是Mac OS/iOS平台特有的文件格式。Framework实际上是一种打包方式，将库的二进制文件、头文件和有关的资源打包到一起，方便管理和分发。Framework有静态库也有动态库，静态库的Framwork = .a+头文件+资源文件 + 签名；动态库的framework=.dylib+头文件+资源文件 + 签名。
我们自己创建的Framework和系统的Framework比如（UIKit.framework）还是有很大的区别的。系统的Framework不需要拷贝到目标程序中，我们自己做出来的Framework哪怕是动态库的，最后也还是要拷贝到APP中（APP和Extension的Bundle是共享的），因此苹果又把这种Framework称为Embedded Framework。
Embedded Framework 开发中使用的动态库会被放入ipa下的framework目录下，基于沙盒运行。不同的APP使用相同的动态库，并不会只在系统中存一份，而是会在多个app中各自打包、签名、加载一份。

5.30
1、ModeifiedContent值，修饰器的深层嵌套。
    我们在按钮上使用padding、background和cornerRadius Api并不会简单的取更改按钮的属性。实际上，这些方法（我
    们通常称其为“修饰器”）的调用都会在view树上创建新的一层。在按钮上调用.padding() 会将按钮包装为
    ModeifiedContent类型的值，这个值中包含有关应该如何设置padding填充的信息。在该值上再调用 .background，又会把现有值包装起来，创建另一个 ModifiedContent 值，这一次将添加有关背景色的信息。
    很可能会出现：
    ModifiedContent<ModifiedContent<Text, _FlexFrameLayout>, _EnvironmentKeyWritingModifier<Optional<Color>>>, _EnvironmentKeyWritingModifier<Optional<Font>>>
    这样的结果。
    
2、swifui渲染原理。
    swiftui中的View是一个协议，需要遵循body协议。
    当我们界面需要刷新的时候，通过state进行状态管理，当state改变，我们发现是会调用body的。
    也就是说，声明一个属性时，SwiftUI会将当前属性的状态与对应视图的绑定，当属性的状态发生改变的时候，
    当前视图会销毁以前的状态并及时更新，
    
    需要理解的重要一点是，当我们将修改器应用于视图时，我们并没有直接修改它。没有要真正修改的属性。
    相反，当应用修改器时，会返回一个ModifiedContent，它包装了我们应用修改器的视图。
    比如：
    let view = Rectangle().frame(width: 100, height: 100)
    type(of: view) // ModifiedContent<Rectangle, _FrameLayout>

    // ModifyContent，其实结构很简单
    struct ModifiedContent<Content, Modifier> {

        var content: Content
        var modifier: Modifier
    }

    请注意，Modified Content在其声明中没有实现View协议。相反，ModifiedContent根据Content和Modifier
    通用属性实现的协议实现了不同的协议。这种方法使ModifiedContent本身尽可能简单，同时允许其可扩展。

    ModifiedContent实现View，例如，当Content和Modifier分别实现View和ViewModifier协议时。
    extension ModifiedContent: View where Content: View, Modifier: ViewModifier 
    { ... }

    Scene和Widget的ModifiedContent也以相同的方式实现，但使用SceneModifier和WidgetModifier。
    ViewModifer是一个协议，唯一的要求是一个body功能。
    public protocol ViewModifier {
        associatedtype Body : SwiftUI.View
        func body(content: Self.Content) -> Self.Body
    }
    
3、关于视图View。
    struct ContentView: View {
        var body: some View {
            Text("Hello, world!")
                .background(Color.yellow)
                .font(.title)
                .dump()
        }
    }

    extension View {
        func dump() -> Self {
            print(Mirror(reflecting: self))
            return self
        }
    }
    打印结果：
    Mirror for ModifiedContent<ModifiedContent<Text, _BackgroundModifier<Color>>, _EnvironmentKeyWritingModifier<Optional<Font>>>

    struct ContentView_: View {
        var body: some View {
            Group {
                if true {
                    Color.yellow
                } else {
                    Text("Impossible")
                }
            }
            .dump()
        }
    }
    打印结果：
    Mirror for Group<_ConditionalContent<Color, Text>>
    虽然Text永远不会变得可见，但它仍然存在于_ConditionalContent<Color, Text>.
    

5、async/await、actor。 
    actor的引入其实就是为了解决数据争夺的。


6.2
1、PreferencKey。
    PreferenceKey是一个协议：
    public protocol PreferenceKey {

        associatedtype Value
        // 默认值
        static var defaultValue: Self.Value { get }
        // 主要是处理，当父试图找到多个值时候，value值应该怎么处理。
        static func reduce(value: inout Self.Value, nextValue: () -> Self.Value)
    }
    我们发现其实很简单，就一个defaultValue和reduce方法。
    a>首先PreferenceKey是为了解决子视图传信息给父试图的。
    b>工作原理也很简单，就是通过key-value的方式进行传值。
    c>经常配合onPreferenceChange一起使用，父试图通过onPreferenceChange来获取子类传的值。
    d>当然还有overlayPreferenceValue、backgroundPreferenceValue等modify可以使用。
    d>注意Anchor的使用。Anchor其实是一个结构体。

2、Swiftui布局流程分为三个步骤：
    1、父试图将为子视图提供建议大小。
    2、子视图会选择自己的大小。（注意，在swiftui中，父试图无法强制其子视图设置大小，因为必须尊重子视图）
    3、然后，父试图需要将子视图放置在其自己的坐标空间中的某个位置。默认会放在中心。


3、GeometryReader。它将占用父级给出的建议大小。
    GeometryReader其实和ZStack有点像，但是不能设置aligment属性，而且默认是对方在左上角的。
    GeometryReader中GeometryProxy，直接获取size，就是当前试图的size，其实和geo.frame(in: .loacal)、geo.frame(in: .global)获取的size是一样的。
    但是其frame的x、y这些肯定是不一样的。
    特点就是：
    .gloabal是相对屏幕的空间。
    .loacal是相对父试图的控件。
    相对于其它试图，可以使用自定义空间。


6.6
1、ViewBuilder。
    @_functionBuilder struct ViewBuilder，可能结果构造器
    
    @available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
    extension ViewBuilder {
        public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> TupleView<(C0, C1)> where C0 : View, C1 : View
    }

    @ViewBuilder有一个静态buildBlock方法，改方法接受两个试图，将它们组合并返回TupleView。
    当然它还有其它BuildBlock方法，它接受1到10个子视图，它们都将子视图组合成一个TupleView。这就是为什么@ViewBuilder最多只能接受十个视图的原因。
    
    @ViewBuilder还能通过if和switch表达式的支持。

2、Mirror反射
    public struct Mirror {

          public enum DisplayStyle {
            case `struct`, `class`, `enum`, tuple, optional, collection
            case dictionary, `set`
          }
    
        // 表示类型，被反射主体的类型
        public let subjectType: Any.Type

        // 所有的熟悉
        public let children: Children

        // 显示类型，基本类型为nil 枚举值: struct, class, enum, tuple, optional, collection, dictionary, set
        public let displayStyle: DisplayStyle?

        /// 父类反射， 没有父类为nil
        public var superclassMirror: Mirror? {
          return _makeSuperclassMirror()
        }
    }
    
    // 如果是oc的话，是基于runtime的，所以获取动态类型及成员信息是很方便的。 但是swift静态语言，要动态获取属性这些就必须借助Mirror这个结构体。

3、Environment获取系统环境设置的。 当我们Swiftui创建第一个View的时候，系统就已经创建了一个Environment。

    SwiftUI使用Environment来传递系统范围的设置，例如ContentSizeCategory、LayoutDirection、ColorScheme等。

4、Modifier。
    我们都知道，每次一个View进行.xxxx操作的时候，都会生成一个新的ModifiedContent。这个是最基本的原理。
    每次我们将Modifier应用到SwiftUI视图时，我们实际上创建了一个应用了该Modifier的新的视图（注意：并不会在原地修改现有视图)。如果我们仔细想想，这种行为是
    很有道理的：我们的View其实是struct，保存的也是确切的属性，所以如果我们设置背景颜色或者字体大小，就没有地方存储这些数据了。
    比如：
    Button("Hello, world!") {
    // do nothing
    }    
    .background(.red)
    .frame(width: 200, height: 200)
    
    上面的代码并不会生成带有"Hello，world"的200*200红色按钮。这点和UIKit是有很大差别的。 
    我们其实看到的是200*200的空放个，上面是红色矩形，红色矩形里面是“Hello,wrold”


6.8
1、UIKit和SwiftUI混合开发。
    UIKit使用SwiftUI，通过UIHostingController进行包装。
    SwiftUi使用UIKit，通过UIViewRepresentable来添加。

2、Github现在不让使用密码登录，需要使用token登录，这里就有点麻烦，登录还好，但是如果要进行push和pull的认证就很麻烦。所以我们最好使用ssh进行认证。
    首先要github上配置ssh。 其实配置完成后，mac电脑下面~/.ssh里面会有isa_xxx的文件，同时github -> setting -> ssh上面就会有相应的key。
    这样我们在配置项目，时候就可以将url 替换为 git:xxxx 这样的路径。不要使用https。
    
6.28
1、PropertyWrapper。是swift新增的特性。其目的就是移除一些多余、重复的代码。

6.29
1、JSONSerialization、JSONEncoder、JSONDecoder。是苹果暴露的跟json有关的操作的几个关键结构体。
    JsonSerialization是将json对象 <---> Data之前的转换。
    JsonEncoder和JsonDecoder是 json对象 <---> 模型之间的转换。需要转换的模型遵循Codeable协议。

2、理解DispatchQueue中target的含义。其实就是将当前线程的优先级跟target的一样。


7.6
1、编程语言一般由三种函数分发机制：直接分发、表（Table)、Message。一般语言都是支持直接分发和表。比如Java默认是Table，可以使用final转换为直接分发，
    C++默认是表（Table），可是用使用virtual来使用表。OC默认是message。Swift是默认都支持三种默认。
    
    直接分发Direct、如果我们将其翻译成会变语言，就会发现是call 0xxxxxxxxxx。直接调用函数地址。但是有个缺点就是不能进行重写。
    
    表：一般是Vitual table，但是swift称之为见证表（Witness table)。每个子类都有表的副本。
    其实原理很简单，就是建立一个table，然后函数的指针放在table中。函数调用其实就是在table中找到函数地址，然后调用。子类增加方法就是直接在table尾部增加。
    这就有一个很明显的缺陷，extension不能修改table（试想，如果可以那么：A->B。A中有新增方法，这个时候我如果extension B中新增方法，那么明显新增的方法不知道放在什么位置）。

23.6.9
1、关于Int和UInt，官方建议直接使用Int，这样可以避免类型的来回转换。

23.6.16
1、UINavigationBarAppearance，其中有三种默认配置的样式
        configureWithOpaqueBackground维持某个颜色，一般设置完成后，需要设置backgroudColor
        configureWithTransparentBackground导航栏透明
        configureWithDefaultBackground毛玻璃效果

23.9.1
AnyObject是一个协议。而AnyClass是元类型，即AnyObject.Type

10.13 线程爆炸
沒有一個明確數字指多少 thread 才算是太多。一般來說，我們可以參考這段 WWDC 影片的範例，當中系統運行中的 thread 數量是其 CPU core 的 16 倍，這就算是 thread explosion。
因為 Grand Central Dispatch (GCD) 沒有內置機制來防止 thread explosion。
线程资源消耗：线程并不是无成本的。每个线程都有其自己的堆栈，而且需要时间进行上下文切换。如果线程数量过多，它们将占用大量内存，并且频繁的上下文切换将消耗大量 CPU 时间。这可能会导致应用程序响应变慢，甚至出现内存不足的情况。

因此我們可以確定，Swift Concurrency 就是利用一個專用的 concurrent queue 來限制 thread 的數量，讓它不過多於 CPU core，來防止 thread explosion：

2024.2.18
1、不透明类型some
    具有不透明返回类型的函数或方法会隐藏返回值的类型信息。函数不再提供具体的类型作为返回类型，而是根据它支持的协议来描述返回值。在处理模块和调用代码之间的关系时，隐藏类型信息非常有用，因为返回的底层数据类型仍然可以保持私有。而且不同于返回协议类型，不透明类型能保证类型一致性：编译器能获取到类型信息，同时模块使用者却不能获取到。
    
在 Swift 中，当你看到错误信息 "Use of protocol 'View' as a type must be written 'any View'"，这是因为 Swift 语言从 Swift 5.5 和 Xcode 13 开始引入了一个新的类型推断规则，用于改进协议类型的使用和泛型的处理。这一变化特别影响到了 SwiftUI 编程。
在这之前，你可以直接使用协议名（比如 View）来代表一个遵循该协议的类型。但是，Swift 5.5 引入的变化要求，当你想要表示一个“任意遵循某协议的类型”时，你需要使用 any 关键字来明确表达这一意图，以此来提高代码的清晰度和一致性。因此，当你尝试将 View 作为类型来使用时，Swift 要求你写成 any View。
func contextMenu<M, P>(
    @ViewBuilder menuItems: () -> M,
    @ViewBuilder preview: () -> P
) -> some View where M : View, P : View

func contextMenu(
    @ViewBuilder menuItems: () -> View,
    @ViewBuilder preview: () -> View
) -> some View 
这就是为什么下面这种写法会报错的原因。

any View 和 some View 都是 Swift 中用于处理协议和泛型相关的关键字，特别是在 SwiftUI 中，它们用于返回遵循 View 协议的类型。它们之间的主要区别在于类型的确定性和透明性。

any View 是一个类型擦除的包装器，用于隐藏实际视图类型的具体细节。这意味着当你使用 any View 作为返回类型时，你可以返回任意遵循 View 协议的视图，无论它们的具体类型是什么。
使用 any View 可以在不同的代码路径中返回不同类型的视图，但这种灵活性是有代价的。any View 会导致一定的性能开销，因为它需要进行类型擦除以隐藏具体的视图类型。
some View 用于指定一个函数或属性将返回某种遵循 View 协议的具体类型，但不指定是哪一种类型。这被称为不透明类型。
使用 some View时，编译器能够保留返回类型的具体信息，这意味着在编译时就确定了返回的具体类型，而这个具体类型对于调用者来说是不可见的。
不透明类型（some View）提供了更好的性能和类型安全性，因为编译器知道确切的类型信息，但它要求每个使用 some View 的地方返回相同的视图类型。这对于条件语句不是很方便，因为所有的条件分支都必须返回相同类型的视图。
何时使用哪个
使用 some View：当你的函数或属性总是返回相同类型的视图，或者你希望保留关于返回类型的具体信息时。这是 SwiftUI 中的常见用法，因为它提供了更好的性能和类型安全性。
使用 any
    View：当你需要在不同的条件下返回不同类型的视图时，或者当函数需要返回多种不同类型的视图时。这提供了更高的灵活性，但以性能和一些类型安全性为代价。
总的来说，some View 通常是首选，因为它提供了更好的编译时类型检查和性能。但在需要高度灵活性的情况下，any View 是一个有用的工具。

let a: View.Protocol = View.self，也就是Protocol.self的类型是Protocol.Protocol，而并不是我们想的那样Protocol.Type
