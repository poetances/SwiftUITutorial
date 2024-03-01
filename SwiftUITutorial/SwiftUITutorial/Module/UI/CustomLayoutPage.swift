//
//  CustomLayoutPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/28.
//

import SwiftUI

struct CustomLayoutPage: View {

    private let contents = [
        Content(title: "Creat", destination: .create)
    ]
    // MARK: - system
    var body: some View {
        List(contents) { content in
            NavigationLink(content.title, value: content.destination)
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationDestination(for: Destination.self) { des in
            switch des {
            case .create:
                CreateCustomLayoutTutorial()
            }
        }
    }
}

extension CustomLayoutPage {

    enum Destination {
        case create
    }

    struct Content: Identifiable {
        let id = UUID()
        let title: String
        let destination: Destination
    }
}

#Preview {
    CustomLayoutPage()
}
