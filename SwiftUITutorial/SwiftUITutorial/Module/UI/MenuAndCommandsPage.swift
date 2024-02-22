//
//  MenuAndCommandsPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/20.
//

import SwiftUI

struct MenuAndCommandsPage: View {


    private var contents = [
        Content(title: "Menu", destination: .menu),
        Content(title: "ContextMenu", destination: .contextMenu)
    ]

    // MARK: - system
    var body: some View {
        List {
            ForEach(contents) { content in
                NavigationLink(content.title, value: content.destination)
            }
        }
        .navigationTitle("MenuAndCommands")
        .navigationDestination(for: Destination.self) { des in
            switch des {
            case .menu:
                MenuTutorial()
            case .contextMenu:
                ContextMenuTutorial()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

extension MenuAndCommandsPage {

    struct Content: Identifiable {
        let id = UUID()

        let title: String
        let destination: Destination
    }

    enum Destination {
        case menu
        case contextMenu
    }
}

#Preview {
    MenuAndCommandsPage()
}
