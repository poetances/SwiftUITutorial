//
//  CreateCustomLayoutTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/29.
//

import SwiftUI

/*
 Layout协议，作用很简单，可以根据自己的需要创建合适自己的布局。
 里面必须实现的两个方法，sizeThatFits，获取大小

 A collection of proxy values that represent the subviews of a layout view.
 LayoutSubViews: Collection
 typealias Element = LayoutSubview
 typealias Index = Int
 typealias SubSequence = LayoutSubviews

 A proxy that represents one subview of a layout.
 LayoutSubview

 Placing the subview
 func place(at: CGPoint, anchor: UnitPoint, proposal: ProposedViewSize)
    Assigns a position and proposed size to the subview.
 
 Getting subview characteristics
 func dimensions(in: ProposedViewSize) -> ViewDimensions
    Asks the subview for its dimensions and alignment guides.
 func sizeThatFits(ProposedViewSize) -> CGSize
    Asks the subview for its size.
 var spacing: ViewSpacing
    The subviews’s preferred spacing values.
 var priority: Double
    The layout priority of the subview.

 以及创建好的Layout:
 AnyLayout
 HStackLayout、VStackLayout、ZStackLayout、GridLayout
 */
struct CreateCustomLayoutTutorial: View {

    var body: some View {
        MyEqualWidthHStack {
            Text("Hello")
            Text("World!")
            Text("Hello, World!")
        }
    }
}

struct MyEqualWidthHStack: Layout {

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard !subviews.isEmpty else { return .zero }

        let maxSize = maxSize(subviews: subviews)
        let spacing = spacing(subviews: subviews)
        let totalSpacing = spacing.reduce(0) { $0 + $1 }

        return CGSize(
            width: maxSize.width * CGFloat(subviews.count) + totalSpacing,
            height: maxSize.height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard !subviews.isEmpty else { return }


        let maxSize = maxSize(subviews: subviews)
        let spacing = spacing(subviews: subviews)


        let placementProposal = ProposedViewSize(width: maxSize.width, height: maxSize.height)
        var nextX = bounds.minX + maxSize.width / 2


        for index in subviews.indices {
            subviews[index].place(
                at: CGPoint(x: nextX, y: bounds.midY),
                anchor: .center,
                proposal: placementProposal)
            nextX += maxSize.width + spacing[index]
        }
    }

//    func makeCache(subviews: Subviews) -> CacheData {
//        let maxSize = maxSize(subviews: subviews)
//        let spacing = spacing(subviews: subviews)
//        let totalSpacing = spacing.reduce(0) { $0 + $1 }
//
//
//        return CacheData(
//            maxSize: maxSize,
//            spacing: spacing,
//            totalSpacing: totalSpacing)
//    }
//
//    struct CacheData {
//        let maxSize: CGSize
//        let spacing: [CGFloat]
//        let totalSpacing: CGFloat
//    }
}

private extension MyEqualWidthHStack {
    func maxSize(subviews: Subviews) -> CGSize {
        let subviewSizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let maxSize: CGSize = subviewSizes.reduce(.zero) { currentMax, subviewSize in
            CGSize(
                width: max(currentMax.width, subviewSize.width),
                height: max(currentMax.height, subviewSize.height))
        }

        return maxSize
    }

    func spacing(subviews: Subviews) -> [CGFloat] {
        subviews.indices.map { index in
            guard index < subviews.count - 1 else { return 0 }
            print(subviews[index].spacing.distance(
                to: subviews[index + 1].spacing,
                along: .horizontal), subviews[index].sizeThatFits(.unspecified))
            return subviews[index].spacing.distance(
                to: subviews[index + 1].spacing,
                along: .horizontal)
        }
    }
}

#Preview {
    CreateCustomLayoutTutorial()
}
