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
        Content("PropertyWrapper", .propertyWrapper),
        Content("ResultBuilder", .resultBuilder),
        Content("RenderLoop", .renderLoop),
        Content("SwiftMacro", .macro),
        Content("AttibutedString", .attibutedString),
        Content("ModelData", .modelData),
        Content("Environment", .environment),
        Content("Preference", .preference),
        Content("Storage", .storage),
        Content("CoreData", .coreData)
    ]

    // MARK: - system
    var body: some View {
        NavigationStack {

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
                case .modelData:
                    ModelDataPage()
                case .environment:
                    EnvironmentPage()
                case .preference:
                    PreferencePage()
                case .storage:
                    StoragePage()
                case .coreData:
                    CoreDataTutorial()
                }
            }
            .navigationDestination(for: String.self) { _ in
                AttributedStringTutorial()
            }
        }
        .toolbarBackground(Color.pink, for: .navigationBar, .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarColorScheme(.dark, for: .tabBar)
    }
}

extension CorePage {
    enum Destination {
        case propertyWrapper
        case resultBuilder
        case renderLoop
        case macro
        case attibutedString
        case modelData
        case environment
        case preference
        case storage
        case coreData
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
