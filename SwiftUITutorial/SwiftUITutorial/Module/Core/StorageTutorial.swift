//
//  StorageTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/6.
//

import SwiftUI

/*
 @frozen @propertyWrapper public struct AppStorage<Value> : DynamicProperty {

     public var wrappedValue: Value { get nonmutating set }

     public var projectedValue: Binding<Value> { get }
 }

 因为遵循DynamicProperty，所以其值更改，那么UI也会刷新。
 注意：
 @AppStorage("name") private var name = "Gust"
 当第一次启动时候，let name = UserDefaults.standard.string(forKey: "name")获取的name为空。
 因为默认值，只是给了name一个默认值，如果当前key = "name"没有值时候，则会使用默认值

 @frozen @propertyWrapper public struct SceneStorage<Value> : DynamicProperty {

     /// The underlying value referenced by the state variable.
     ///
     /// This works identically to `State.wrappedValue`.
     ///
     /// - SeeAlso: State.wrappedValue
     public var wrappedValue: Value { get nonmutating set }

     /// A binding to the state value.
     ///
     /// This works identically to `State.projectedValue`.
     ///
     /// - SeeAlso: State.projectedValue
     public var projectedValue: Binding<Value> { get }
 }
 Each Scene has its own notion of SceneStorage, so data is not shared between scenes.
 不同场景有不同的SceneStorage

 If the Scene is explicitly destroyed (e.g. the switcher snapshot is destroyed on iPadOS or the window is closed on macOS), the data is also destroyed. Do not use SceneStorage with sensitive data.
 如果场景销毁，保存的数据也销毁，所以不要存储敏感数据

 SceneStorage是一个属性包装器，它用于在窗口（或场景）的生命周期内持久存储简单的数据。@SceneStorage的主要目的是帮助在应用程序的不同运行周期或者窗口的关闭和重新打开之间保存和恢复用户界面的状态。这对于构建良好的多窗口支持和在iPadOS、macOS等平台上提供更好的用户体验非常有用。
 @SceneStorage的作用包括但不限于：

 状态恢复：可以在用户关闭窗口或应用程序后，下次打开时恢复用户界面的某些状态，如滚动位置、选项卡选择、文本字段内容等。
 多窗口支持：在支持多窗口的应用中，不同的窗口（或场景）可以有其独特的状态，@SceneStorage允许每个窗口保存自己的状态，独立于其他窗口。
 简化状态管理：由于@SceneStorage自动处理数据的保存和加载，开发者可以减少手动管理和持久化UI状态的代码，专注于业务逻辑。

 */
struct StorageTutorial: View {
    @AppStorage(wrappedValue: 10, "age") private var age
    @AppStorage("name") private var name = "Gust"

    @SceneStorage("text") private var text = ""
    @SceneStorage("tabviewIndex") private var index = 0

    @FocusState private var focused: Bool

    // MARK: - system
    var body: some View {
        ScrollView(content: {
            VStack(spacing: 15) {
                Text(name)
                Button("Read name") {
                    let name = UserDefaults.standard.string(forKey: "name")
                    print(name ?? "nil ")
                }
                Button("Change name") {
                    name += " David"
                }
                Divider()
                Text("\(age)")
                Button("Read age") {
                    let age = UserDefaults.standard.integer(forKey: "age")
                    print(age)
                }
                Button("Change age") {
                    age += 1
                }
                Divider()
                TextEditor(text: $text)
                    .textEditorStyle(.plain)
                    .focused($focused)
                    .background(Color.pink)
                    .padding()
                Button("Read text") {
                    let text = UserDefaults.standard.string(forKey: "text")
                    print(text ?? "nil")
                }
                Divider()
                TabView(selection: $index,
                        content:  {
                    Text("Tab Content 1").tabItem { Text("Tab Label 1") }.tag(1)
                    Text("Tab Content 2").tabItem { Text("Tab Label 2") }.tag(2)
                })
                EmptyView().frame(height: 20)
            }
        })
        .onTapGesture {
            focused = false
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    StorageTutorial()
}
