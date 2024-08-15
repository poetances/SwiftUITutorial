//
//  DrawingAndGraphicsTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/6.
//

import SwiftUI

struct DrawingAndGraphicsTutorial: View {

    var body: some View {
        List(Destination.allCases, id: \.rawValue) { des in
            NavigationLink(des.rawValue.capitalized, value: des)
        }
        .navigationTitle("DrawingAndGraphics")
        .navigationDestination(for: Destination.self) { des in
            switch des {
            case .canvas:
                CanvasTutorial()
            }
        }
    }
}

extension DrawingAndGraphicsTutorial {

    enum Destination: String, CaseIterable {
        case canvas
    }
}

#Preview {
    DrawingAndGraphicsTutorial()
}

