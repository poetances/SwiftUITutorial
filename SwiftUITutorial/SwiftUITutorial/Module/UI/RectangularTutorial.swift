//
//  RectangularTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/22.
//

import SwiftUI

/*
 Rectangular默认背景黑色
 */
struct RectangularTutorial: View {
    var body: some View {
        VStack(spacing: 15) {

            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundStyle(.red)

            /*
             RoundedCornerStyle代表了了圆角样式：
             .circular 样式，圆角的形状基于圆的一部分。这意味着无论视图的尺寸如何变化，圆角保持标准圆形的一部分，圆角的曲率不会随视图大小的变化而变化。

             .continuous 样式创建的是一种更平滑、自然的曲线，它的曲率会根据视图的尺寸而变化。这种样式受到苹果设计语言中“超椭圆”或“斯库莫夫”（Squircle）形状的启发。
             */
            RoundedRectangle(cornerRadius: 25.0, style: .circular)
                .frame(width: 100, height: 100)
                .foregroundStyle(.red)

            /*
             UnevenRoundedRectangle，可以指定圆角位置

             RectangleCornerRadii制定圆角位置
             */
            UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 25, bottomTrailing: 25))
                .frame(width: 100, height: 100)
                .foregroundStyle(.red)

        }
        .border(.blue)
    }
}

extension RectangularTutorial {


}

#Preview {
    RectangularTutorial()
}
