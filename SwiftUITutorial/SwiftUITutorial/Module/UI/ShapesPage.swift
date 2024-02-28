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

    private let contents = [
        Content(title: "Rectangular", destination: .rectangular),
        Content(title: "Circle", destination: .circle),
        Content(title: "Path", destination: .path),
        Content(title: "Shape", destination: .shape)
    ]
    // MARK: - system
    var body: some View {
        List(contents) { content in
            NavigationLink(content.title, value: content.destination)
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
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

extension ShapesPage {

    struct Content: Identifiable {

        let id = UUID()

        let title: String
        let destination: Destination
    }

    enum Destination: CaseIterable {
        case rectangular
        case circle
        case path
        case shape
    }
}

#Preview {
    ShapesPage()
}
