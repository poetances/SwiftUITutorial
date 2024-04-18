//
//  SceneStorageTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/4/16.
//

import SwiftUI

/*
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

 从初始化方法，我们可以看出: AppStorage支持的Value类型有：
 String、Int、Data、RawRepresentable、URL、Double、Bool等
 */
struct SceneStorageTutorial: View {

    @SceneStorage("count") private var count = 0
    @SceneStorage("text") private var text = ""

    @FocusState private var focus: Bool

    // MARK: - system
    var body: some View {


        VStack {
            Spacer()
            Text("\(count)")
            Button("Add Count") {
                count += 1
            }

            TextEditor(text: $text)
                .frame(width: 300, height: 150)
                .border(Color.red, width: 1)
                .textEditorStyle(.plain)
                .focused($focus)
            Spacer()
        }
        .onTapGesture {
            focus = false
        }
    }
}

#Preview {
    SceneStorageTutorial()
}
