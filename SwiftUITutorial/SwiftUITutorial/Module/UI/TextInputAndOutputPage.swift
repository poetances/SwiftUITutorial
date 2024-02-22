//
//  TextInputAndOutputPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/21.
//

import SwiftUI

struct TextInputAndOutputPage: View {

    private let contents = [
        Content(title: "Text", destination: .text),
        Content(title: "Label", destination: .label),
        Content(title: "TextField", destination: .textField),
        Content(title: "SecureTextField", destination: .secureTextField),
        Content(title: "TextEditor", destination: .textEditor)
    ]

    // MARK: - system
    var body: some View {

        List(contents) { content in
            NavigationLink(content.title, value: content.destination)
        }
        .textSelection(.enabled)
        .navigationDestination(for: Destination.self) { des in
            switch des {
            case .text:
                TextTutorial()
            case .label:
                LabelTutorial()
            case .textField:
                TextFieldTutorial()
            case .secureTextField:
                SecureTextFieldTutorial()
            case .textEditor:
                TextEditorTutorial()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

extension TextInputAndOutputPage {

    enum Destination {
        case text
        case label
        case textField
        case secureTextField
        case textEditor
    }

    struct Content: Identifiable {

        let id = UUID()

        let title: String
        let destination: Destination
    }
}

#Preview {
    TextInputAndOutputPage()
}
