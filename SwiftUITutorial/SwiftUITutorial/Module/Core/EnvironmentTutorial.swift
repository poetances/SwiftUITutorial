//
//  EnvironmentTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/5.
//

import SwiftUI

struct EnvironmentTutorial: View {
    
    /*
     Don’t call this initializer directly. Instead, declare a property with the Environment property wrapper, passing the object’s type to the wrapper (using this syntax, the object type can be omitted from the end of property declaration):

     Environment只能用属性包装器去获取，不要直接初始化
     */
    @Environment(EnvironmentBook.self) private var book
    @Environment(\.colorScheme) private var colorScheme

    // Default EnvironmetValues
    /*
     var openURL: OpenURLAction { get set }
     struct OpenURLAction {
         func callAsFunction(URL)
         Opens a URL, following system conventions.
         func callAsFunction(URL, completion: (Bool) -> Void)
         Asynchronously opens a URL, following system conventions.
     }
     */
    @Environment(\.openURL) private var openUrl

    /*
     var openWindow: OpenWindowAction { get }
     struct OpenWindowAction {
         func callAsFunction(id: String)
         Opens a window that’s associated with the specified identifier.
         func callAsFunction<D>(id: String, value: D)
         Opens a window defined by the window group that presents the specified value type and that’s associated with the specified identifier.
         func callAsFunction<D>(value: D)
     }
     */
    @Environment(\.openWindow) private var openWindow

    // @Environment(\.purchase) private var purchase
    @Environment(\.refresh) private var refresh
    @Environment(\.rename) private var rename

    // scrolling
    @Environment(\.isScrollEnabled) private var isScrollEnabled
    @Environment(\.horizontalScrollIndicatorVisibility) private var horizontalScrollIndicatorVisibility
    @Environment(\.verticalScrollIndicatorVisibility) private var verticalScrollIndicatorVisibility
    @Environment(\.horizontalScrollBounceBehavior) private var horizontalScrollBounceBehavior
    @Environment(\.verticalScrollBounceBehavior) private var verticalScrollBounceBehavior

    var body: some View {
        RefreshableView()
            .refreshable {
                print("Refresh finished!")
            }

        ScrollView {
            VStack(spacing: 15) {
                Text("Environment book \(book.name)")
                NavigationLink("ChildView") {
                    EnvironmentChildView()
                }
                Divider()
                Text("ColorScheme \(colorScheme == .dark ? "Dark":"Light")")
                Button("Change ColorScheme") {
                    // Failed to produce diagnostic for expression; please submit a bug report (https://swift.org/contributing/#reporting-bugs)
                    // colorScheme = .dark
                    /*
                     You can use this property wrapper to read — but not set — an environment value. SwiftUI updates some environment values automatically based on system settings and provides reasonable defaults for others. You can override some of these, as well as set custom environment values that you define, using the environment(_:_:) view modifier.

                     也就是说：Environment获取系统的环境变量，是不能进行设置的。只有自定义的环境变量才能进行设置
                     */
                }
                Divider()
                Button("OpenUrl") {
                    let url = URL(string: "https://www.baidu.com")!
                    // openUrl(url)
                    openUrl(url) { accepted in
                        print(accepted.description)
                    }
                }
                Text("Visit [Example Company](https://www.baidu.com) for details.")
                    .environment(\.openURL, OpenURLAction(handler: { url in
                        // handleURL(url)
                        print(url)
                        return .handled
                    }))
                Divider()
                Button("OpenWindow") {
                    // openWindow(id: "mail-viewer")
                    // Cannot open windows when app does not support multiple scenes
                    // 也就是说iOS手机上是不支持多多Scenes
                }
                Divider()
                RenameButton()
                    .renameAction {
                        print("rename action")
                    }
                Divider()
                Text("isScrollEnabled: \(isScrollEnabled.description)")
            }
        }
        .refreshable {
            print("refresh start")
            try! await Task.sleep(nanoseconds: 3_000_000_000)
            print("refresh end")
        }
    }
}

// MARK: - Environment
extension EnvironmentTutorial {

}

@Observable
class EnvironmentBook {
    var name: String = ""
    var isAvailable: Bool = false
}

#Preview {
    EnvironmentTutorial()
}

struct EnvironmentChildView: View {
    @Environment(EnvironmentBook.self) var book

    // MARK: - system
    var body: some View {
        Text("\(book.name)")
        Button("Change") {
            book.name += "book "
        }
        .environment(\.customBook, ModelDataBook())
    }
}


// Custom EnvironmentValues
struct BookKey: EnvironmentKey {
    static var defaultValue = ModelDataBook()
}

extension EnvironmentValues {
    var customBook: ModelDataBook {
        get { self[BookKey.self] }
        set { self[BookKey.self] = newValue }
    }
}

struct RefreshableView: View {
    @Environment(\.refresh) private var refresh
    @Environment(\.isScrollEnabled) private var isScrollEnabled


    var body: some View {
        Text("isScrollEnabled: \(isScrollEnabled.description)")
        Button("Refresh") {
            Task {
                await refresh?()
            }
        }
        .disabled(refresh == nil)
    }
}
