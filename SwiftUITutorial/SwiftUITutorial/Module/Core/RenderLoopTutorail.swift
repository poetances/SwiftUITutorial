//
//  RenderLoopTutorail.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/1/10.
//

import SwiftUI
import Observation

/*
 https://fatbobman.com/zh/posts/swiftuilifecycle/
 
 swiftui 渲染机制。是基于render loop实现的。

 event loop：事件循环，基于消息事件的循环，例如触摸被系统包装成一个事件一层一层传递给 UI 组件并最终触发 UI 组件渲染。
 render loop：渲染循环，是一个更小的概念，更多关注在消息处理和屏幕渲染上
 invalidated：无效、失效，类似于 Flutter 的 dirty 。当一个 View 的关联属性改变了，或者其他原因导致 View 需要刷新，View 就会被标记为 invalidated，此时框架会对 View 的body 进行 evaluate 。
 evaluate：直译是评估，我更倾向于翻译成计算，也就是当框架发现一个 View 被标记为 invalidated 后，框架会尝试比对改变前和改变后的 body 内容。如果框架认为 body 内容改变了，就会重新渲染。注意，evaluation 并不一定会导致重新渲染，这取决于框架对 body 的评估结果。评估虽然不会必然导致渲染，但框架仍需读取 body 数据并进行（可能复杂的）计算以确定内容是否改变。关于这部分内容，本文并没有着重展开，感兴趣的朋友可以阅读

 当一个应用程序出现卡顿时，你认为它不可能是卡顿，因为还有一些动画在进行中？即使应用程序的主线程被卡住，指示器（菊花）仍在旋转，这总是让我困惑。即使主线程繁忙或暂停，iOS中的动画也可以继续。这不是因为动画发生在另一个线程中，而是因为它们发生在另一个进程中。
 操作系统使用合成器来允许多个进程显示图形，然后在同一屏幕上的不同窗口中绘制它们。iOS 也有一个合成器，但它不仅仅是用来在分屏或应用切换器中同时绘制不同的窗口。它还被用来绘制应用程序中的不同 CALayers，并绘制动画。这个过程，即 render server，执行了 Core Animation 的大部分魔法。

Flutter的工作方式与传统的iOS或Android开发有所不同，尤其是在线程和渲染机制方面。Flutter使用单线程模型，所有的UI更新和业务逻辑通常都在一个线程（即UI线程）上执行。这意味着如果主线程（UI线程）被阻塞或卡顿，那么动画和屏幕渲染也会受到影响，导致动画停止或出现卡顿。

 在iOS中，UI的更新和动画也是依赖于一帧一帧的渲染机制。当一个动画被触发时，系统会计算动画的每一帧，并逐帧发送给GPU进行渲染。这个过程涉及到Core Animation和Metal或OpenGL等图形API。
 在Flutter中，每当UI需要更新时，都会生成一个新的帧，并在UI线程上构建和布局这个帧。然后，这个帧会被发送到GPU进行渲染。如果UI线程被阻塞，那么新的帧就不能及时生成和发送，导致动画和UI更新停滞。
 关键差异
 多线程与GPU加速: 尽管iOS上的UI更新和动画准备通常发生在主线程上，一些动画和渲染工作可以通过Core Animation和GPU加速独立于主线程进行。这意味着即使主线程被阻塞，某些类型的动画（如基于硬件加速的动画）仍然可以继续进行，因为它们的渲染工作是由GPU独立完成的。

 SwiftUI 没有同 UIkit（AppKit）对应的视图与视图生命周期
 应避免对 SwiftUI 视图的创建、body 的调用、布局与渲染等的时机和频率进行假设
 在 SwiftUI 内部它会至少创建两种类型的树——类型树、视图值树
 结构体的 body 属性是一个带有众多泛型参数的庞大类型，SwiftUI 会将这些类型组织成一棵类型树。它包含了 app 生命周期中可能会出现在屏幕上的所有符合 View 协议的类型（即使可能永远不会被渲染）。

 在 app 运行后进行第一次渲染时，SwiftUI 将依据类型树按图索骥，创建类型实例，实例的 body 根据初始状态计算视图值，并组织成视图值树。需要创建哪些实例，则是根据当时的状态决定的，每次的状态变化都可能会导致最终生成的视图值树不同（可能仅是某个节点的视图值发生变化，也可能是视图值树的结构都发生了巨大的变化）。

 当 State 发生变化后，SwiftUI 会生成一棵新的视图值树（Source of truth 没有发生变化的节点，不会重新计算，直接使用旧值），并同老的视图值树进行比对，SwiftUI 将对其中有变化的部分重新布局渲染，并用新生成的视图值树取代老的视图值树。

 初始化视图实例——注册数据依赖——调用 body 计算结果——onAppear——销毁实例——onDisapper


 符合 View 协议的结构体实例的生命周期
 初始化
 通过在结构体的构造函数中添加打印命令，我们很容易就可以获知 SwiftUI 创建了某个结构体的实例。如果你仔细分析构造函数的打印结果，你会发现创建结构体实例的时机和频率远超你的预期。

 */
struct RenderLoopTutorail: View {
    
    @StateObject var vm = RenderLoopViewModel()

    // MARK: - system
    init() {
        print("Render Loop init")
    }

    var body: some View {

        Group {
            let _ = print("-----body init")
            Text("\(vm.count)").padding()
            Text(vm.statusText).padding()
            Button("Fetch") {
                vm.fetch()
            }
        }
        .onAppear {
            print("Render Loop Appear")
        }
        .onDisappear {
            print("Render Loop disappear")
        }
    }
}

#Preview {
    RenderLoopTutorail()
}

/*
 @Published 属性的调用规律：
 即时更新: 当 @Published 属性的值发生变化时，立即触发订阅视图的更新。
 合并更新: 如果多个 @Published 属性几乎同时发生变化，SwiftUI 可以选择合并这些更新，以减少不必要的视图重绘。
 主线程: 所有影响 UI 的更新必须在主线程上执行。如果你在后台线程更新 @Published 属性，你需要确保使用 DispatchQueue.main 来切换回主线程。

 */
class RenderLoopViewModel: ObservableObject {

    @Published var statusText = "invalid"

    @Published var count: Int = 0

    func fetch() {
        statusText = "loading-\(count)"
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            DispatchQueue.main.async {
                self.count += 1
            }
        }
    }
}

