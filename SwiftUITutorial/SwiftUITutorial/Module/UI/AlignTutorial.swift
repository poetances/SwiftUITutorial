//
//  AlignTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/28.
//

import SwiftUI

/*
 alignmentGuide(_:computeValue:)
 就一个方法，但是牵扯到的结构体确很多：
 HorizontalAlignment
 VerticalAlignment

 ViewDimensions
 A view’s size and alignment guides in its own coordinate space.
 里面内容很重要：
 var height: CGFloat
    The view’s height.
 var width: CGFloat
    The view’s width.
 subscript(explicit _: VerticalAlignment) -> CGFloat?
    Gets the explicit value of the given vertical alignment guide
 subscript(explicit _: HorizontalAlignment) -> CGFloat?
    Gets the explicit value of the given horizontal alignment guide.
 */
struct AlignTutorial: View {
    var body: some View {
        VStack {
            HStack {
                Text("Today's Weather")
                    .font(.title)
                    .border(.gray)

                HStack {
                    Text("🌧")
                    Text("Rain & Thunderstorms")
                    Text("⛈")
                }
                .alignmentGuide(VerticalAlignment.center, computeValue: { dimension in
                    print(dimension.width, dimension.height)
                    return dimension[.top] / 2
                })
            }
        }
    }
}

#Preview {
    AlignTutorial()
}
