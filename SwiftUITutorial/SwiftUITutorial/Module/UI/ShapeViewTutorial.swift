//
//  ShapeViewTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/6/19.
//

import SwiftUI

/*
 protocol ShapeView<Content> : View
 Use this type with the drawing methods on Shape to apply multiple fills and/or strokes to a shape. For example, the following code applies a fill and stroke to a capsule shape:
 ShapeView就是当Shape使用了strok 或者 fill生成的view即下面的几种，他们就是遵循了ShapeView。

 FillShapeView
 StrokeBorderShapeView
 StrokeShapeView
 遵循了ShapeView

 */
struct ShapeViewTutorial: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ShapeViewTutorial()
}
