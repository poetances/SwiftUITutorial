//
//  PathTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/23.
//

import SwiftUI

/*
 Path:
 Animatable
 CustomStringConvertible
 Equatable
 LosslessStringConvertible
 Sendable
 Shape
 View

 比较重要的协议View、Animationable。表示可以直接作用View展示
 */
struct PathTutorial: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                creating_path
                getting_path_characteristics
                drawing_path
                transforming_path
            }
        }
    }
}

// MARK: - creating path
extension PathTutorial {

    /*
     init方式里面有RectangleCornerRadii，可以关注下
     */
    var creating_path: some View {
        ScrollView(.horizontal) {
            HStack {
                Path(CGRect(x: 0, y: 0, width: 50, height: 100))
                    .frame(width: 200, height: 200)
                    .border(.red)

                Path(roundedRect: CGRect(x: 0, y: 0, width: 50, height: 100), cornerSize: CGSize(width: 5, height: 10), style: .circular)
                    .frame(width: 200, height: 200)
                    .border(.pink)

                Path(roundedRect: CGRect(x: 0, y: 0, width: 50, height: 100), cornerRadii: RectangleCornerRadii(topLeading: 25, bottomTrailing: 25))
                    .frame(width: 200, height: 200)
                    .border(.cyan)
            }
        }
    }
}

// MARK: - getting path characteristics(特性)
extension PathTutorial {
    
    /*
     var boundingRect: CGRect { get }
     var cgPath: CGPath { get }
     func contains(
         _ p: CGPoint,
         eoFill: Bool = false
     ) -> Bool
     var currentPoint: CGPoint? { get }
     var isEmpty: Bool { get }
     */
    var getting_path_characteristics: some View {
        HStack {
            let path = Path(CGRect(x: 0, y: 0, width: 50, height: 100))
            path.frame(width: 200, height: 200)
                .border(.red)

            VStack(alignment: .leading) {
                Text(path.description)
                Text("Path is Empty: \(path.isEmpty.description)")
            }
        }

    }
}

// MARK: - drawing path
extension PathTutorial {

    var creatPath: Path {
        var path = Path()
        path.move(to: .zero)
        path.addRoundedRect(in: CGRect(x: 0, y: 0, width: 50, height: 100), cornerSize: CGSize(width: 25, height: 25))
        return path
    }

    var drawing_path: some View {
        HStack {
            creatPath
                .offsetBy(dx: 100, dy: 100)
                .frame(width: 200, height: 200)
                .border(.red)
        }
    }
}

// MARK: - transforming path
extension PathTutorial {

    var transforming_path: some View {
        ScrollView(.horizontal) {
            HStack {
                // applying(_:)
                creatPath
                    .applying(CGAffineTransform(rotationAngle: 2))
                    .frame(width: 200, height: 200)
                    .border(.red)

                // offsetBy(dx:dy:)
                creatPath
                    .offsetBy(dx: 100, dy: 100)
                    .frame(width: 200, height: 200)
                    .border(.pink)

                /*
                 trimmedPath(from:to:)
                 trimmedPath(from:to:)方法允许你根据起始点和终点的比例值来裁剪路径。这些比例值的范围是0到1，其中0表示路径的开始，1表示路径的结束。

                 这个方法非常适合于创建加载指示器、进度条或者任何需要部分显示路径的场景。例如，如果你有一个表示进度的圆环，你可以使用trimmedPath来根据进度值动态显示圆环的一部分。
                 */
                creatPath
                    .trimmedPath(from: 0, to: 0.5)
                    .frame(width: 200, height: 200)
                    .border(.indigo)

                Circle()
                    .stroke(lineWidth: 20)
                    .foregroundColor(.blue)
                    .opacity(0.3) // 整个圆环的底色
                    .overlay(
                        Circle()
                            .trim(from: 0, to: 0.5) // 根据进度裁剪路径
                            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                            .foregroundColor(.blue)
                            .rotationEffect(Angle(degrees: -90)) // 从顶部开始绘制
                    )
                    .padding()
            }
        }
    }
}

#Preview {
    PathTutorial()
}
