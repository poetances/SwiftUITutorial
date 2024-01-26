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
        Content("modal", .modalpresentations)
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
