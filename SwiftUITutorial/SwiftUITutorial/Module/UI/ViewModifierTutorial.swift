//
//  ViewModifierTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/18.
//

import SwiftUI
import Charts

/*
 SwiftUI中的所有视图，包含了View和ViewModifier
 
 所有的View，增加modifer之后返回的就是ModifierContent类型

 牵扯的另外一个结构体：EmptyModifier，一般用户开发调试的。


 SwiftUI提供了几个常见的view：
 AnyView：用于类型擦除
 EmptyView: 用于占位，不占大小和内容
 */
struct ViewModifierTutorial: View {
    private var someCondition = true


    var body: some View {
        Text("Downtown Bus")
            .borderedCaption()
    }
}

// MARK: - AnyView
extension ViewModifierTutorial {

    /*
     AnyView长用于类型擦除
     */
    var anyView: some View {
        if someCondition {
            AnyView(Image(systemName: "pencil"))
        } else {
            AnyView(Text(""))
        }
    }
}

// MARK: - EmptyView
extension ViewModifierTutorial {

    var emptyView: some View {
        #if DEBUG
            return Image(systemName: "pencil")
        #else
            return EmptyView()
        #endif
    }
}

// MARK: - EquatableView
extension ViewModifierTutorial {

    /*
     EquatableView 在 SwiftUI 中用于优化性能，特别是在处理复杂视图时。在 SwiftUI，视图体的重建是非常常见的操作，每当状态变化时，相关的视图就会重新计算其视图体。对于一些复杂的视图来说，这个过程可能会变得相当昂贵，特别是当视图的重新计算并不总是因为其自身的状态变化引起的。这就是 EquatableView 发挥作用的地方。

     EquatableView 的作用
     EquatableView 包裹一个视图，并使这个被包裹的视图只在其相关数据发生改变时才重建其视图体。它通过对视图的输入进行等价性检查来实现这一点，如果视图的输入自上次渲染以来没有变化，那么 SwiftUI 就可以跳过重建这个视图的过程。

     使用场景
     使用 EquatableView 最常见的场景是当你有一个依赖于某些外部状态或属性但这些状态或属性变化频繁导致视图不必要的重建时。通过将这个视图包裹在 EquatableView 中，并实现 Equatable 协议来定义何时视图应该被认为是“相等”的，从而减少不必要的视图重建，优化性能。
     */
    var equatableView: some View {
        EquatableView(content: MyView(data: ""))
    }

    struct MyView: View, Equatable {
        let data: String

        static func == (lhs: MyView, rhs: MyView) -> Bool {
            return lhs.data == rhs.data
        }

        var body: some View {
            Text("Hello, World!")
        }
    }
}

// MARK: - TupleView
extension ViewModifierTutorial {

    /*
     在大多数情况下，开发人员并不需要直接与 TupleView 交互。当你在视图体中返回多个视图时，SwiftUI 会自动将它们包装在一个 TupleView 中。例如，在 VStack、HStack、或 ZStack 中使用多个视图时，实际上就是在使用 TupleView。
     */
    var tupleView: some View {
        let s = VStack(content: {
            Text("Downtown Bus")
            Divider()
            Text("Downtown Bus")
        })

        let _ = print(Mirror(reflecting: s))
        return Text("xxxx")
    }
}

#Preview {
    ViewModifierTutorial()
}

struct BorderedCaption: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.caption2)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 1)
            )
            .foregroundColor(Color.blue)
    }
}

extension View {

    func borderedCaption() -> some View {
        modifier(BorderedCaption())
    }
}

// MARK: - EmptyModifier
struct EmptyViewModifierContentView: View {
    var body: some View {
        Text("Hello, World!")
            .modifier(modifier)
    }


    var modifier: some ViewModifier {
        #if DEBUG
            return BorderedCaption()
        #else
            return EmptyModifier()
        #endif
    }
}



