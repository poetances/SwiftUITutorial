//
//  UIPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2023/12/1.
//

import SwiftUI

struct UIPage: View {

    private let contents = [
        Content("App", .app),
        Content("Scene", .scene),
        Content("Window", .window),
        Content("DocumentGroup", .documentgroup),
        Content("Navigation", .navigation),
        Content("TabView", .tabview),
        Content("Modal", .modalpresentations),
        Content("ToolBar", .toolbar),
        Content("Search", .search),
        Content("AppearanceModifiers", .appearanceModifiers),
        Content("DrawingAndGraphics", .drawingAndGraphics),
        Content("ViewModifierTutorial", .viewModifierTutorial),
        Content("ViewStyles", .viewStyles),
        Content("ControlsAndIndicators", .controlsAndIndicators)
    ]

    @State private var isShowDetail = false

    // MARK: - system
    var body: some View {
        NavigationStack {
            List {
                ForEach(contents) { content in
                    NavigationLink(content.title, value: content.destination)
                }
                Section {
                    Button("Show Detail") {
                        isShowDetail.toggle()
                    }
                }
            }
            .scrollContentBackground(.visible)
            .environment(\.defaultMinListRowHeight, 46)
            .navigationDestination(for: Destination.self) { des in
                switch des {
                case .app:
                    AppTutorial()
                case .scene:
                    SceneTutorail()
                case .window:
                    WindowTutorial()
                case .documentgroup:
                    DocumentGroupToturial()
                case .navigation:
                    NavigationTutorial()
                case .tabview:
                    TabViewTutorial()
                case .modalpresentations:
                    ModalPresentationsTutorial()
                case .toolbar:
                    ToolBarToturial()
                case .search:
                    SearchTutorial()
                case .appearanceModifiers:
                    AppearanceModifiersTutorial()
                case .drawingAndGraphics:
                    DrawingAndGraphicsTutorial()
                case .viewModifierTutorial:
                    ViewModifierTutorial()
                case .viewStyles:
                    ViewStylesPage()
                case .controlsAndIndicators:
                    ControlsAndIndicatorsPage()
                }
            }
            .navigationDestination(isPresented: $isShowDetail) {
                DetailView()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("UI")

        }
    }
}

extension UIPage {
    enum Destination {
        case app
        case scene
        case window
        case documentgroup
        case navigation
        case tabview
        case modalpresentations
        case toolbar
        case search
        case appearanceModifiers
        case drawingAndGraphics
        case viewModifierTutorial
        case viewStyles
        case controlsAndIndicators
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

    struct DetailView: View {
        var body: some View {
            Text("Detail View")
        }
    }
}


#Preview {
    UIPage()
}
