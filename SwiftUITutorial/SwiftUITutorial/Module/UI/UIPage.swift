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
        Content("ViewModifierTutorial", .viewModifierTutorial),
        Content("ViewStyles", .viewStyles),
        Content("Animations", .animations),
        Content("Images", .images),
        Content("TextInputAndOutput", .textInputAndOutput),
        Content("ControlsAndIndicators", .controlsAndIndicators),
        Content("MenuAndCommands", .menuAndCommands),
        Content("Shape", .shape),
        Content("DrawingAndGraphics", .drawingAndGraphics),
        Content("LayoutFundamentals", .layoutFundamentals),
        Content("LayoutAdjustments", .layoutAdjustments),
        Content("CustomLayout", .customLayout),
        Content("List", .list),
    ]

    @State private var isShowDetail = false

    @State private var searchText = ""

    // MARK: - system
    var body: some View {
        NavigationStack {
            List {
                ForEach(contents) { content in
                    NavigationLink(content.title, value: content.destination)
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
                case .viewModifierTutorial:
                    ViewModifierTutorial()
                case .viewStyles:
                    ViewStylesPage()
                case .animations:
                    AnimationsPage()
                case .images:
                    ImagesPage()
                case .textInputAndOutput:
                    TextInputAndOutputPage()
                case .controlsAndIndicators:
                    ControlsAndIndicatorsPage()
                case .menuAndCommands:
                    MenuAndCommandsPage()
                case .shape:
                    ShapesPage()
                case .drawingAndGraphics:
                    DrawingAndGraphicsTutorial()
                case .layoutFundamentals:
                    LayoutsFundamentalsPage()
                case .layoutAdjustments:
                    LayoutAdjustmentsPage()
                case .customLayout:
                    CustomLayoutPage()
                case .list:
                    ListPage()
                }
            }
            .navigationDestination(isPresented: $isShowDetail) {
                DetailView()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("UI")
        }
        .toolbarBackground(.white, for: .tabBar)
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
        case viewModifierTutorial
        case viewStyles
        case animations
        case controlsAndIndicators
        case menuAndCommands
        case textInputAndOutput
        case images
        case shape
        case drawingAndGraphics
        case layoutFundamentals
        case layoutAdjustments
        case customLayout
        case list
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
