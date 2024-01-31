//
//  CorePage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2023/12/1.
//

import SwiftUI

struct CorePage: View {
    @EnvironmentObject private var appDelegate: SwiftUIAppDelegate

    @State private var paths = [Destination]()

    private var contents = [
        Content("StateObject", .stateObject),
        Content("PropertyWrapper", .propertyWrapper),
        Content("ResultBuilder", .resultBuilder),
        Content("RenderLoop", .renderLoop),
        Content("SwiftMacro", .macro),
        Content("AttibutedString", .attibutedString)
    ]

    // MARK: - system
    var body: some View {
        NavigationStack(path: $paths) {

            List {
                ForEach(contents) { content in
                    NavigationLink(content.title, value: content.destination)
                }

                Section {
                    Button("Use Path") {
                        paths.append(.attibutedString)
                    }
                }
            }
            .environment(\.defaultMinListRowHeight, 46)
            .navigationTitle("Core")
            .navigationDestination(for: Destination.self) { des in
                switch des {
                case .stateObject:
                    StateObjectTutorial()
                case .propertyWrapper:
                    PropertyWrapperTutorial()
                case .resultBuilder:
                    ResultBuildTutorial()
                case .renderLoop:
                    RenderLoopTutorail()
                case .macro:
                    SwiftMacroTutorail()
                case .attibutedString:
                    AttributedStringTutorial()
                }
            }
            .toolbarBackground(Color.blue, for: .navigationBar, .tabBar)
            .toolbarRole(.browser)
        }
    }
}

extension CorePage {
    enum Destination {
        case stateObject
        case propertyWrapper
        case resultBuilder
        case renderLoop
        case macro
        case attibutedString
    }

    struct Content: Identifiable {
        let id = UUID()

        let title: String
        let destination: Destination
        init(_ title: String, _ destination: Destination) {
            self.title = title
            self.destination = destination
        }
    }
}

#Preview {
    CorePage()
}
