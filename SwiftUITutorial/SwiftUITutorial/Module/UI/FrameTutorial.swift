//
//  FrameTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/28.
//

import SwiftUI

struct FrameTutorial: View {
    var body: some View {
        VStack {
            frame
            container_relative_frame
            fixed_size
            layout_priority
        }
    }
}

// MARK: - Influencing a view size
extension FrameTutorial {

    /*
     Positions this view within an invisible frame with the specified size.
     这句话很重要，也就是说会将试图放在不可见的框架大小中。
     这也解释了为什么frame有aligment
     func frame(
         width: CGFloat? = nil,
         height: CGFloat? = nil,
         alignment: Alignment = .center
     ) -> some View
     width:
     A fixed width for the resulting view. If width is nil, the resulting view assumes this view’s sizing behavior.
     height:
     A fixed height for the resulting view. If height is nil, the resulting view assumes this view’s sizing behavior.
     alignment:
     The alignment of this view inside the resulting frame. Note that most alignment values have no apparent effect when the size of the frame happens to match that of this view.
     这三个参数的解释非常重要。可以加深我们对frame的理解。
     */
    var frame: some View {
        ScrollView {
            VStack {
                Ellipse()
                    .fill(Color.purple)
                    .frame(width: 200, height: 100)
                Ellipse()
                    .fill(Color.blue)
                    .frame(height: 100)

                Text("Hello world!")
                    .frame(width: 200, height: 30, alignment: .topLeading)
                    .border(Color.gray)

                Ellipse()
                    .fill(Color.pink)
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: 200, minHeight: 0, idealHeight: 100, maxHeight: 200, alignment: .center)
            }
        }
    }


    var container_relative_frame: some View {
        VStack {
            /*
             func containerRelativeFrame(
                 _ axes: Axis.Set,
                 alignment: Alignment = .center
             ) -> some View
             相当于每一个占用整个窗口
             */
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<10) { i in
                        Text("Item \(i)")
                            .foregroundStyle(.white)
                            .containerRelativeFrame(.horizontal)
                            .background(.red)
                    }
                }
            }

            /*
             func containerRelativeFrame(
                 _ axes: Axis.Set,
                 alignment: Alignment = .center,
                 _ length: @escaping (CGFloat, Axis) -> CGFloat
             ) -> some View
             通过指定length来指定其占用窗口的大小
             */
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<10) { i in
                        Text("Item \(i)")
                            .foregroundStyle(.white)
                            .containerRelativeFrame(.horizontal, { length, axi in
                                length / 2
                            })
                            .background(.blue)
                    }
                }
            }

            /*
             func containerRelativeFrame(
                 _ axes: Axis.Set,
                 count: Int,
                 span: Int = 1,
                 spacing: CGFloat,
                 alignment: Alignment = .center
             ) -> some View
             通过指定比例来指定占用窗口大小
             */
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<10) { i in
                        Text("Item \(i)")
                            .foregroundStyle(.white)
                            .containerRelativeFrame(.horizontal, count: 5, span: 2, spacing: 10.0) // 相当于每个窗口占用2/5
                            .background(.blue)
                    }
                }
            }
        }
    }

    /*
     fixedSize()
     Fixes this view at its ideal size.
     下面的例子很好的说明了fixedSize的作用，就是固定到理想中的尺寸
     */
    var fixed_size: some View {
        ScrollView(.horizontal) {
            HStack {
                Text("A single line of text, too long to fit in a box.")
                    .frame(width: 200, height: 200)
                    .border(Color.gray)

                Text("A single line of text, too long to fit in a box.")
                    .fixedSize()
                    .frame(width: 200, height: 200)
                    .border(Color.gray)

                Text("A single line of text, too long to fit in a box.")
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(width: 200, height: 200)
                    .border(Color.gray)
            }
        }
    }

    /*
     layoutPriority(_:)
     Sets the priority by which a parent layout should apportion space to this child.
     Views typically have a default priority of 0 which causes space to be apportioned evenly to all sibling views. Raising a view’s layout priority encourages the higher priority view to shrink later when the group is shrunk and stretch sooner when the group is stretched.

     默认优先级是0，可以通过该修饰符，可以改变优先级.
     */
    var layout_priority: some View {
        HStack {
            Text("This is a moderately long string.")
                .font(.largeTitle)
                .border(Color.gray)


            Spacer()


            Text("This is a higher priority string.")
                .font(.largeTitle)
                .layoutPriority(1)
                .border(Color.gray)
        }
    }
}

#Preview {
    FrameTutorial()
}
