//
//  ListPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/29.
//

import SwiftUI

struct ListPage: View {

    private let contents = [
        Content(title: "List", destination: .list),
        Content(title: "Section", destination: .section),
        Content(title: "ForEach", destination: .forEach),
        Content(title: "OutlineGroup", destination: .outlineGroup),
        Content(title: "DisclosureGroup", destination: .disclosureGroup),
        Content(title: "ConfiguringRows", destination: .configuringRows),
        Content(title: "ConfiguringSeperators", destination: .configuringSeperators),
        Content(title: "ConfiguringHeaders", destination: .configuringHeaders),
        Content(title: "ConfiguringSpacing", destination: .configuringSpacing),
    ]

    // MARK: - system
    var body: some View {
        List(contents) { NavigationLink($0.title, value: $0.destination)}
            .toolbar(.hidden, for: .tabBar)
            .navigationDestination(for: Destination.self) { des in
                switch des {
                case .list:
                    ListTutorial()
                case .section:
                    SectionTutorial()
                case .forEach:
                    ForEachTutorial()
                case .outlineGroup:
                    OutlineGroupTutorial()
                case .disclosureGroup:
                    DisclosureGroupTutorial()
                case .configuringRows:
                    ConfiguringRowsTutorial()
                case .configuringSeperators:
                    ConfiguringSeperatorsTutorial()
                case .configuringHeaders:
                    ConfiguringHeadersTutorial()
                case .configuringSpacing:
                    ConfiguringSpacingTutorial()
                }
            }
    }
}

extension ListPage {

    enum Destination {
        case list
        case section
        case forEach
        case outlineGroup
        case disclosureGroup
        case configuringRows
        case configuringSeperators
        case configuringHeaders
        case configuringSpacing
    }

    struct Content: Identifiable {

        let id = UUID()

        let title: String
        let destination: Destination
    }
}

#Preview {
    ListPage()
}
