//
//  SwiftUITutorialApp.swift
//  SwiftUITutorial
//
//  Created by zcj on 2023/12/1.
//

import SwiftUI

// @main属于App中static func main函数。
@main
struct SwiftUITutorialApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @UIApplicationDelegateAdaptor private var appDelegate: SwiftUIAppDelegate
    @AppStorage("isDarkMode") var isDarkMode = false

    @State private var path: NavigationPath = NavigationPath()

    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            print("window group::", oldPhase, newPhase)
        }
        .defaultSize(width: 400, height: 400) // 只在mac、ipad上起作用
        // .defaultAppStorage(UserDefaults(user: "Custom"))。 

        // Cannot open windows when app does not support multiple scenes
        // iphone os是不支持多场景的
        WindowGroup(id: "mail-viewer") {
            Text("MailViewwer")
           
        }
    }
}



/*

 AnyObject
 The protocol to which all classes implicitly conform.

 public typealias AnyClass = AnyObject.Type

 Protocol
 很多人对 Protocol 的元类型容易理解错。Protocol 自身不是一个类型，只有当一个对象实现了 protocol 后才有了类型对象。所以 Protocol.self 不等于 Protocol.Type。如果你写下面的代码会得到一个错误：
 protocol MyProtocol { }
 let metatype: MyProtocol.Type = MyProtocol.self

 let protMetatype: MyProtocol.Protocol = MyProtocol.self


 NSObjectProtocol
 The protocol to which NSObject classes implicitly conform.

 */

// 如果遵循，其它地方就可以通过    @EnvironmentObject private var appDelegate: SwiftUIAppDelegate 进行获取
class SwiftUIAppDelegate: NSObject, UIApplicationDelegate, ObservableObject {

    func applicationDidFinishLaunching(_ application: UIApplication) {

    }
}

extension SwiftUIAppDelegate {

    // 通过UISceneConfiguration来进行配置，将其生命周期进行转换，用SwiftUIWindowSceneDelegate来进行管理
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        if connectingSceneSession.role == .windowApplication {
            configuration.delegateClass = SwiftUIAppDelegate.self
        }
        return configuration
    }
}

class SwiftUIWindowSceneDelegate: NSObject, UIWindowSceneDelegate {

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }
}
