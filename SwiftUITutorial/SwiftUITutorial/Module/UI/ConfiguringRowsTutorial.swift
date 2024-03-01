//
//  ConfiguringRowsTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/3/1.
//

import SwiftUI

/*
 listRowInsets(_:)

 listItemTint(_:)
 listItemTint(_:)
 在 SwiftUI 中，listItemTint 是一个用于调整列表项（List Item）前景色（例如，导航箭头、行为按钮等）的修饰符。它允许你为列表中的项设置一种统一的颜色主题，使得整个列表的视觉效果更加协调。
 注意：listxxxx是修饰cell的，需要注意使用位置。
 */
struct ConfiguringRowsTutorial: View {
    var body: some View {

        List(0 ..< 20) { index in
            Text("Item \(index)")
                .listRowInsets(EdgeInsets(top: 0, leading: CGFloat(10 * index), bottom: 0, trailing: 0))
                .listItemTint(.indigo)
        }
    }
}

#Preview {
    ConfiguringRowsTutorial()
}
