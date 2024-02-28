//
//  LayoutAdjustmentsPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/28.
//

import SwiftUI

/*


 */
struct LayoutAdjustmentsPage: View {

    private let contents = [
        Content(title: "Padding", destination: .padding),
        Content(title: "Frame", destination: .frame),
        Content(title: "Position", destination: .position),
        Content(title: "Align", destination: .align),
        Content(title: "Margin", destination: .margin),
        Content(title: "SafeArea", destination: .safeArea)
    ]

    // MARK: - system
    var body: some View {
        List(contents) { content in
            NavigationLink(content.title, value: content.destination)
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationDestination(for: Destination.self) { des in
            switch des {
            case .padding:
                PaddingTutorial()
            case .frame:
                FrameTutorial()
            case .position:
                PositionTutorial()
            case .align:
                AlignTutorial()
            case .margin:
                MarginTutorial()
            case .safeArea:
                SafeAreaTutorial()
            }
        }
    }
}

extension LayoutAdjustmentsPage {
    struct Content: Identifiable {
        let id = UUID()
        let title: String
        let destination: Destination
    }

    enum Destination {
        case padding
        case frame
        case position
        case align
        case margin
        case safeArea
    }
}


#Preview {
    LayoutAdjustmentsPage()
}
