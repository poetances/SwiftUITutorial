//
//  ControlsAndIndicatorsPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/19.
//

import SwiftUI

struct ControlsAndIndicatorsPage: View {

    private var contents = [
        Content(title: "Button", destination: .button),
        Content(title: "EditButton", destination: .editButton),
        Content(title: "PasteButton", destination: .pasteButton),
        Content(title: "RenameButton", destination: .renameButton),
        Content(title: "Link", destination: .link)
    ]

    // MARK: - system
    var body: some View {
        List(contents) {
            NavigationLink($0.title, value: $0.destination)
        }
        .navigationTitle("ControlsAndIndicators")
        .navigationDestination(for: Destination.self) { des in
            switch des {
            case .button:
                ButtonTutorial()
            case .editButton:
                EditButtonTutorial()
            case .pasteButton:
                PasteButtonTutorial()
            case .renameButton:
                RenameButtonTutorial()
            case .link:
                LinkTutorial()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

extension ControlsAndIndicatorsPage {

    struct Content: Identifiable {

        let id = UUID()

        let title: String
        let destination: Destination
    }

    enum Destination {
        case button
        case editButton
        case pasteButton
        case renameButton
        case link
    }
}

#Preview {
    ControlsAndIndicatorsPage()
}
