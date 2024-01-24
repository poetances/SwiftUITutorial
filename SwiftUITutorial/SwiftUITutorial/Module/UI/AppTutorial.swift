//
//  AppTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/1/21.
//

import SwiftUI

struct AppTutorial: View {
    var body: some View {
        ScrollView {
            content
        }
    }

    var content: some View {
        Text(
"""
App，一个协议。
public protocol App {

    /// The type of scene representing the content of the app.
    ///
    /// When you create a custom app, Swift infers this type from your
    /// implementation of the required ``SwiftUI/App/body-swift.property``
    /// property.
    associatedtype Body : Scene

    /// The content and behavior of the app.
    ///
    /// For any app that you create, provide a computed `body` property that
    /// defines your app's scenes, which are instances that conform to the
    /// ``SwiftUI/Scene`` protocol. For example, you can create a simple app
    /// with a single scene containing a single view:
    ///
    ///     @main
    ///     struct MyApp: App {
    ///         var body: some Scene {
    ///             WindowGroup {
    ///                 Text("Hello, world!")
    ///             }
    ///         }
    ///     }
    ///
    /// Swift infers the app's ``SwiftUI/App/Body-swift.associatedtype``
    /// associated type based on the scene provided by the `body` property.
    @SceneBuilder @MainActor var body: Self.Body { get }

    /// Creates an instance of the app using the body that you define for its
    /// content.
    ///
    /// Swift synthesizes a default initializer for structures that don't
    /// provide one. You typically rely on the default initializer for
    /// your app.
    @MainActor init()
}

extension App {

    /// Initializes and runs the app.
    ///
    /// If you precede your ``SwiftUI/App`` conformer's declaration with the
    /// [@main](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html#ID626)
    /// attribute, the system calls the conformer's `main()` method to launch
    /// the app. SwiftUI provides a
    /// default implementation of the method that manages the launch process in
    /// a platform-appropriate way.
    @MainActor public static func main()
}

另外几个重要点，UIScreen、UIScreens在Info.plist中的配置

struct UIApplicationDelegateAdaptor<DelegateType> where DelegateType : NSObject, DelegateType : UIApplicationDelegate
"""
        )
    }
}



#Preview {
    AppTutorial()
}
