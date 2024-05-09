//
//  BindingTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/4/17.
//

import SwiftUI

/**
 了解了您提供的完整代码，现在可以更准确地解释为什么BindingContentView中的UI在您点击按钮时不会刷新，即使@Binding遵循DynamicProperty。

 首先，重要的是要明确@Binding确实是一个DynamicProperty，它旨在让数据的变化能够反映到UI上。然而，@Binding本身并不负责存储数据或触发视图的更新。它是一个引用，指向某个可触发视图更新的状态（比如@State）。当@Binding引用的数据发生变化时，由于@Binding指向的是可触发更新的状态，所以对应的视图会重新渲染。

 在您的例子中，BindingContentView的count通过一个自定义的Binding传递，这个Binding的get闭包每次被调用时都修改并返回全局变量tmp的值。这里的关键问题是：

 全局变量tmp的修改并不会触发任何视图的重新渲染。即使tmp的值在get闭包中被修改，这个修改并没有被SwiftUI框架所"监听"，因为tmp不是一个@State或其他会触发视图更新的SwiftUI管理的状态变量。
 自定义Binding的set闭包并没有修改任何可以触发视图更新的状态。这意味着即使您在BindingContentView中点击按钮，尽管set闭包被调用并打印了新值，但没有任何状态被修改为可以让SwiftUI知道需要更新UI。
 如何让BindingContentView响应变化？
 为了让BindingContentView正确响应变化，您需要确保@Binding指向的是可以触发视图更新的状态，例如一个@State变量。在您的示例中，如果您希望点击BindingContentView中的按钮时更新视图，您应该确保按钮的点击操作修改的是能够触发BindingTutorial视图更新的@State变量。

 一个简单的解决方案是，确保BindingContentView的count能够回传至BindingTutorial里的@State private var count，这样当count被修改时，BindingTutorial视图能够响应这个变化。但在您的示例中，由于自定义Binding的set闭包并没有修改任何实际的状态，所以这个通信链是断开的。

 结论
 @Binding确实是设计来反映数据变化的，但它需要正确地指向或修改能够触发视图更新的状态。单纯地修改一个全局变量或在set闭包中执行打印操作，并不足以触发SwiftUI的视图更新机制。正确的做法是让@Binding与能够影响视图渲染的状态（如@State）相连接，并确保这些状态的修改能够被SwiftUI框架捕捉到，从而触发视图的重新渲染。


 SwiftUI 的刷新机制基于声明式UI原理，主要通过数据驱动的方式来更新界面。核心原理是当数据状态发生变化时，SwiftUI 会自动重绘对应的视图。这种机制依赖于SwiftUI框架内部对状态变化的监听，以及如何将这些状态绑定到UI组件上。
 */
var tmp = 0


struct BindingTutorial: View {

    @State private var count = 0

    // MARK: - system
    var body: some View {
        let _ = print("Binding", count)
        VStack(spacing: 15) {
            Text("\(count)")

            Button {
                count += 1
            } label: {
                Text("Binding Add")
            }

            BindingContentView(count: .init(get: {
                print("start getting binding value")
//                tmp += 1
//                return tmp
                return count
            }, set: { v in
                count = v
                print("start setting binding value", v)
            }))
        }
    }
}

struct BindingContentView: View {
    @Binding var count: Int

    // MARK: - system
    var body: some View {
        let _ = print("Binding content", count)
        VStack(spacing: 15) {
            Text("\(count)")
            

            Button {
                count += 1
            } label: {
                Text("Binding Content Add")
            }
        }
    }
}

#Preview {
    BindingTutorial()
}
