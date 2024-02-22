//
//  ViewStylesPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/18.
//

import SwiftUI

struct ViewStylesPage: View {

    private var contents = [
        Content(title: "ButtonStyle", destination: .buttonStyle),
        Content(title: "PickerStyle", destination: .pickerStyle),
        Content(title: "MenuStyle", destination: .menuStyle),
        Content(title: "ToggleStyle", destination: .toggleStyle),
        Content(title: "GaugeStyle", destination: .gaugeStyle),
        Content(title: "ProgressViewStyle", destination: .progressViewStyle),
        Content(title: "LabelStyle", destination: .labelStyle),
        Content(title: "TextFieldStyle", destination: .textFieldStyle)

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
            case .pickerStyle:
                PickerStyleTutorial()
            case .menuStyle:
                MenuStyleTutorial()
            case .toggleStyle:
                ToggleStyleTutorial()
            case .gaugeStyle:
                GaugeStyleTutorial()
            case .progressViewStyle:
                ProgressViewStyleTutorial()
            case .labelStyle:
                LabelStyleTutorial()
            case .textFieldStyle:
                TextFieldStyleTutorial()
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
        case pickerStyle
        case menuStyle
        case toggleStyle
        case gaugeStyle
        case progressViewStyle
        case labelStyle
        case textFieldStyle
    }
}

#Preview {
    ViewStylesPage()
}
