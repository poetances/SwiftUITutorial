//
//  ShapeTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/23.
//

import SwiftUI

/*
 Shape协议：
 Animatable
 Sendable
 View

 遵循Shape协议的类型很多
 AnyShape
 ButtonBorderShape
 Capsule
 Circle
 ContainerRelativeShape
 Ellipse
 OffsetShape
 Path
 Rectangle
 RotatedShape
 RoundedRectangle
 ScaledShape
 TransformedShape
 UnevenRoundedRectangle

 其它的Shape类型：
 StrokeShapeView
 You don’t create this type directly; it’s the return type of Shape.stroke.

 StrokeBorderShapeView
 You don’t create this type directly; it’s the return type of Shape.strokeBorder.

 FillShapeView
 You do not create this type directly, it is the return type of Shape.fill.

 ScaledShape
 RotatedShape
 OffsetShape
 TransformedShape
 通过Transform变换的，变换后位置样式
 */
struct ShapeTutorial: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                standard_shape
                shape_size_path
                transform_shape
                strok_shape
                fill_shape
                insettable_shape
            }
        }
    }
}

// MARK: - creating standard shape
extension ShapeTutorial {

    /*
     Shape的static方法有几个要求:
     比如：ButtonBorderShape
     A shape that defers to the environment to determine the resolved button border shape.
     Available when Self is ButtonBorderShape.

     */
    var standard_shape: some View {
        ScrollView(.horizontal, content: {
            HStack {
                Circle.circle

                Rectangle.rect
                    .stroke(lineWidth: 2)
                    .frame(width: 100)

                ButtonBorderShape.buttonBorder
                    .frame(width: 100)

                Capsule.capsule
                    .frame(width: 100)

                Ellipse.ellipse
                    .frame(width: 100)

                UnevenRoundedRectangle.rect(topLeadingRadius: 25, bottomTrailingRadius: 25)
                    .frame(width: 100)

                Circle.circle.size(width: 100.0, height: 100.0)
            }
        })
        .frame(height: 200)
        .foregroundStyle(.indigo)
    }
}

// MARK: - shapes size path
extension ShapeTutorial {

    var size_That_Fits_shape: some View {
        let circle = Circle()
        let size = circle.sizeThatFits(.init(width: 100, height: 200))
        return circle.overlay {
            Text("Size: \(size.debugDescription)")
                .foregroundStyle(.red)
        }
        .frame(width: 200, height: 200)
    }

    var shape_size_path: some View {
        HStack {
            size_That_Fits_shape
        }
        .frame(height: 200)
    }
}

extension ShapeTutorial {

    /*
     特点：
     所有的Transform变换都是基于原来的frame，Transform之后，原来的frame不变，所以后面所有的布局还是基于原来的frame

     transform(_:) TransformedShape
     scale(_:anchor:) ScaledShape
     rotation(_:anchor:) RotatedShape
     offset(_:) OffsetShape
     */
    var transform_shape: some View {
        ScrollView(.horizontal) {
            HStack {
                // trim 修建
                Circle.circle
                    .trim(from: 0.0, to: 0.5)
                    .border(.red)

                Rectangle()
                    .transform(CGAffineTransform(scaleX: 1.5, y: 1))
                    .border(.red)


                GeometryReader(content: { geometry in
                    RoundedRectangle(cornerRadius: 25.0)
                        .size(width: 100.0, height: 100.0)
                        .border(.red)
                        .overlay {
                            Text(geometry.size.debugDescription)
                                .foregroundStyle(.red)
                        }
                })

                UnevenRoundedRectangle(topLeadingRadius: 25, bottomTrailingRadius: 25)
                    .scale(1.1)
                    .foregroundStyle(.pink)
                    .frame(width: 100)
                    .rotationEffect(.degrees(Double.pi * 2))
                    .border(.blue)

                ScaledShape(shape: .circle, scale: CGSize(width: 1.5, height: 1))
                    .frame(width: 100, height: 100)
                    .border(.pink)
            }
        }
        .frame(height: 200)
    }
}

// MARK: - stroke
extension ShapeTutorial {

    var strok_shape: some View {
        HStack {
            Circle().stroke(.red, lineWidth: 3)
        }
        .frame(height: 200)
    }
}

// MARK: - fill
extension ShapeTutorial {

    /*
     FillStyle确定填充规则，奇偶填充还是非零填充
     */
    var fill_shape: some View {
        ScrollView(.horizontal) {
            HStack {
                Rectangle()

                Circle.circle
                    .intersection(Rectangle().size(width: 100.0, height: 100.0))
                    .fill(.red, style: FillStyle(eoFill: true))
                    .frame(width: 100)

                Circle.circle
                    .lineIntersection(Rectangle().size(width: 100.0, height: 100.0))
                    .fill(.red, style: FillStyle(eoFill: true))
                    .frame(width: 100)

//                Circle.circle
//                    .subtracting(Rectangle().size(width: 100.0, height: 100.0), eoFill: true)
//                    .foregroundStyle(.red)
            }
        }
        .frame(height: 200)
    }
}

// MARK: - InsettableShape
extension ShapeTutorial {
    /*
     InsettableShape: Shape
     提供一个方法增加内缩边距。
     任何遵循InsettableShape协议的形状都需要实现func inset(by amount: CGFloat) -> some InsettableShape方法。这个方法接受一个CGFloat类型的参数，指定了缩进的量，返回一个新的、已经被内缩的形状实例。
     */
    struct MyCustomShape: InsettableShape {
        var insetAmount: CGFloat = 0

        func path(in rect: CGRect) -> Path {
            var path = Path()

            // 定义你的形状
            path.addEllipse(in: rect.insetBy(dx: insetAmount, dy: insetAmount))

            return path
        }

        func inset(by amount: CGFloat) -> some InsettableShape {
            var shape = self
            shape.insetAmount += amount
            return shape
        }
    }

    var insettable_shape: some View {
        HStack {
            Circle().inset(by: 10)
                .border(.red)

            MyCustomShape()
                .inset(by: 20)
                .border(.pink)
        }
        .frame(height: 200)
    }
}


#Preview {
    ShapeTutorial()
}
