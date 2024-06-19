//
//  ShapesPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/22.
//

import SwiftUI

/*
 Trace and fill built-in and custom shapes with a color, gradient, or other pattern.

 Shape一个Protocol。
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
 */
struct ShapesPage: View {

    // MARK: - system
    var body: some View {
        List(Destination.allCases, id: \.rawValue) { des in
            NavigationLink(des.rawValue.capitalized, value: des)
        }
        .navigationDestination(for: Destination.self) { des in
            switch des {
            case .rectangular:
                RectangularTutorial()
            case .circle:
                CircleTutorial()
            case .path:
                PathTutorial()
            case .shape:
                ShapeTutorial()
            case .shapeView:
                ShapeViewTutorial()
            case .anyShape:
                AnyShapeTutorial()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

extension ShapesPage {

    enum Destination: String, CaseIterable {
        case rectangular
        case circle
        case path
        case shape
        case shapeView
        case anyShape
    }
}

#Preview {
    ShapesPage()
}
