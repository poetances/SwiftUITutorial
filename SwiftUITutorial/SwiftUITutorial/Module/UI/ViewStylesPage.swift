//
//  ViewStylesPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/18.
//

import SwiftUI

struct ViewStylesPage: View {

    private var contents = [
        Content(title: "ButtonStyle", destination: .buttonStyle)
    ]

    // MARK: - system
    var body: some View {
        List(contents) { content in
            NavigationLink(content.title, value: content.destination)
        }
        .navigationTitle("ViewStyles")
        // navigationDestination其实可以统一放在最上层，统一管理，看自己需求
        .navigationDestination(for: Destination.self) { des in
            switch des {
            case .buttonStyle:
                ButtonStyleTutorial()
            }
        }
        .toolbar(.hidden, for: .bottomBar)
    }
}

extension ViewStylesPage {

    struct Content: Identifiable {

        let id = UUID()

        let title: String
        let destination: Destination
    }

    enum Destination {
        case buttonStyle
    }
}

#Preview {
    ViewStylesPage()
}
