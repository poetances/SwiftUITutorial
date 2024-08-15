//
//  CanvasTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/6/20.
//

import SwiftUI

struct CanvasTutorial: View {

    @State private var isScale = false
    // MARK: - system
    var body: some View {
        ScrollView {
            canvas
            canvas1
            canvas2
            brightness
            contrast
            scaling
            aspectRadio
            mask
            cliping
            clipShape
            blur
            shadow
            visualEffect
            animtionVisualEffect
            blendMode
            compositingGroup
            geometryReader
        }
        .visualEffect { content, geometryProxy in
            content.opacity(1)
            // content.rotationEffect(.degrees(100))
        }
    }
}

extension CanvasTutorial {

    var canvas: some View {
        Canvas { ctx, size in
            let path = Path(ellipseIn: CGRect(origin: .zero, size: size))
            ctx.stroke(path, with: .color(.red), lineWidth: 5)
        }
        .frame(width: 300, height: 200)
        .border(.blue)
    }

    var canvas1: some View {
        Canvas(opaque: true, colorMode: .linear, rendersAsynchronously: true) { ctx, size in
            var path = Path()
            path.addArc(center: CGPoint(x: 150, y: 100), radius: 100, startAngle: Angle.zero, endAngle: Angle(degrees: .pi * 0.5), clockwise: false)
            ctx.stroke(path, with: .color(.blue), lineWidth: 5)
        }
        .frame(width: 300, height: 200)
        .border(.red)
        .background(Circle().fill(.opacity(0.1)))
    }

    var canvas2: some View {
        Canvas { ctx, size in
            if let mark = ctx.resolveSymbol(id: 0) {
                ctx.draw(mark, in: CGRect(origin: .zero, size: CGSize(width: 50, height: 50)))
            }
        } symbols: {
            Image(systemName: "circle")
                .foregroundStyle(.yellow)
                .tag(0)
        }
        .frame(width: 300, height: 200)
        .background(LinearGradient(
            gradient: Gradient(
                stops: [
                    .init(color: .red, location: 0.0),  // 红色从位置 0.0 开始
                    .init(color: .blue, location: 0.2), // 蓝色在位置 0.5
                    .init(color: .yellow, location: 1.0) // 黄色在位置 1.0 结束
                ]),
            startPoint: .leading,
            endPoint: .trailing
        ))
        // .background(.opacity(0.1), in: Circle())
    }
}

// MARK: - styling content
extension CanvasTutorial {
    /*
     border(_:width:)
     foregroundStyle(_:)
     backgroundStyle(_:)
     */

}

// MARK: - tranform color
extension CanvasTutorial {
    /*
     brightness(_:) // 亮度
     contrast(_:) // 对比度
     colorInvert()
     colorMultiply(_:)
     saturation(_:) // 饱和度
     grayscale(_:) // 灰度
     */
    var brightness: some View {
        HStack {
            ForEach(0..<6) {
                Color.red
                    .frame(width: 60, height: 60)
                    .brightness(Double($0)*0.2)
                    .overlay(Text("\(Double($0) * 0.2 * 100, specifier: "%.0f")%"))
                    .border(.gray)
            }
        }
    }

    var contrast: some View {
        HStack {
            ForEach(0..<6) {
                Color.red
                    .frame(width: 60, height: 60)
                    .contrast(Double($0)*0.2)
                    .overlay(Text("\(Double($0) * 0.2 * 100, specifier: "%.0f")%"))
                    .border(.gray)
            }
        }
    }
}

// MARK: - Scaling、rotating、transforming
extension CanvasTutorial {

    var scaling: some View {
        Circle()
            .fill(Color.red)
            .scaledToFill()
            .scaledToFit()
            .scaleEffect(CGSize(width: 1.0, height: 1.0))
            .frame(width: 300, height: 150)
            .border(.blue)
    }


    var aspectRadio: some View {
        Ellipse()
            .fill(.red)
            .aspectRatio(3/2, contentMode: .fit)
            .frame(width: 300, height: 150)
            .border(.blue)
    }
}

// MARK: - Masking & cliping
extension CanvasTutorial {

    /*
     形状、图案或者是另一个视图，然后这个遮罩会被应用到原始视图上，只显示遮罩形状内的部分，遮罩外的部分则不显示。这样，mask修饰符让你能够创造出复杂和有趣的视图效果，比如圆形图像、特定图形的图标等。
     */
    var mask: some View {
        Image(systemName: "envelope.badge.fill")
            .foregroundColor(Color.blue)
            .font(.system(size: 128, weight: .regular))
            .mask(alignment: .center) {
                Rectangle().opacity(0.1)
            }
    }

    /*
     这里有两个修饰符，fixedSize修饰符用于指示视图忽略其父视图的某些布局约束，保持其理想大小不变。默认情况下，SwiftUI视图会根据父视图和其他布局因素调整其大小。这意味着，有时视图可能会被压缩或扩展，以适应布局中的可用空间。使用fixedSize可以防止这种情况发生，确保视图保持其内容所需的理想尺寸。

     clipped对超出的内容进行裁剪
     */
    var cliping: some View {
        Text("This long text string is clipped")
            .fixedSize()
            .frame(width: 175, height: 100)
            .clipped()
            .border(Color.gray)
    }

    /*
     按指定样式裁剪
     */
    var clipShape: some View {
        Text("Clipped text in a circle")
            .frame(width: 175, height: 100)
            .foregroundStyle(.white)
            .background(.black)
            .clipShape(Circle())
    }
}

// MARK: - blur & shadow
extension CanvasTutorial {

    var blur: some View {
        VStack(spacing: 15) {
            Text("This is some text.")
            Text("This is some blurry text.")
                .blur(radius: 2.0)
        }
        .font(.title)
    }

    var shadow: some View {
        Color.blue
            .frame(width: 100, height: 100)
            .shadow(color: .red, radius: 10, x: 10, y: 10)
    }
}

// MARK: - applying effects base on geometry
extension CanvasTutorial {

    /*
     visualEffect(_:)

     we had view modifiers like scale, offset, blur, contrast, saturation, opacity, rotation, etc.

     第一个参数VisualEffect是一个协议，用于改变视觉效果。
     第二个参数是获取框架信息

     */

    var visualEffect: some View {
        Text("VisualEffect!")
            .visualEffect { content, geometry in
                content
                    .blur(radius: 8)
                    .opacity(0.9)
                    .scaleEffect(.init(width: 2, height: 2))
            }
    }

    /*
     EmptyVisulEffct支持动画
     */
    var animtionVisualEffect: some View {
        VStack {
            Button("Is Scale") {
                isScale.toggle()
            }

            Text("VisualEffect Animation!")
                .visualEffect { content, geometryProxy in
                    content
                        .scaleEffect(
                            x: isScale ? 2 : 1,
                            y: isScale ? 2 : 1
                        )
                }
                .animation(.smooth, value: isScale)
        }
    }
}

// MARK: - compositing views
extension CanvasTutorial {

    var blendMode: some View {
        ZStack {
            Image("37AppStore_icon")
            Image("37iOS_icon")
                .blendMode(.multiply) // 应用混合模式
        }
    }

    var circles: some View {
        ZStack {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
                    .offset(y: -25)

                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .offset(x: -25, y: 25)

                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.green)
                    .offset(x: 25, y: 25)
            }
    }

    var compositingGroup: some View {
        VStack {
            circles
            circles
                .opacity(0.5)
            circles
                .compositingGroup()
                .opacity(0.5)
        }
    }
}

// MARK: - GeometryReader
extension CanvasTutorial {

    /*
     布局原理：
     父view为子view提供一个建议的size
     子view根据自身的特性，返回一个size
     父view根据子view返回的size为其进行布局

     GeometryReader获取父试图提供子视图的size。
     里面有几个重要结构体：
     GeometryProxy
        size...
        frame...
        bouncing...

     // 增加一个命名空间
     func coordinateSpace(_ name: NamedCoordinateSpace) -> some View

     CoordinateSpaceProtocol
        里面有几个重要属性
        .global: GlobalCoordinateSpace
        .local: LocalCoordinateSpace
        .name..: NamedCoordinateSpace

     */
    var geometryReader: some View {
        HStack(spacing: 0.0, content: {
            GeometryReader(content: { geometry in
                let frame = geometry.frame(in: .global)
                Text("Content frame \(frame.origin.x) \(frame.origin.y) \(frame.size.width) \(frame.size.height)")
                    .layoutPriority(1)
            })
        })
        .frame(width: 200, height: 100)
        .border(.green)
    }
}

#Preview {
    CanvasTutorial()
}
