//
//  ContextMenuTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/21.
//

import SwiftUI

/*
 ContextMenu有点类似mac上的右键，一般长按触发。

 比如iOS中，App图标的长按、APPStore中App的长按展示的预览和按钮。都是contextMenu效果
 */
struct ContextMenuTutorial: View {

    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {
            contextMenu
            contextMenu_preview

            NavigationLink("ContxtMenu") {
                ContextMenuItemExample(items: [
                    .init(name: "Apple"),
                    .init(name: "Orange"),
                    .init(name: "Banana"),
                    .init(name: "Pear")
                ])
            }
        }
    }
}


extension ContextMenuTutorial {

    var contextMenu: some View {
        Text("Turtle Rock")
            .contextMenu(menuItems: {
                Text("Menu Item 1")
                Text("Menu Item 2")
                Text("Menu Item 3")
            })
    }

    var contextMenu_preview: some View {
        Button("ContextMenu Preview") {

        }
        .contextMenu {
            Button {
                // Add this item to a list of favorites.
            } label: {
                Label("Add to Favorites", systemImage: "heart")
            }
            Button {
                // Open Maps and center it on this item.
            } label: {
                Label("Show in Maps", systemImage: "mappin")
            }
        } preview: {
            Image("37_icon")
        }

    }
}


#Preview {
    ContextMenuTutorial()
}


struct ContextMenuItemExample: View {
    var items: [Item]
    @State private var selection = Set<Item.ID>()
    

    var body: some View {
        List(selection: $selection) {
            ForEach(items) { item in
                Text(item.name)
            }
        }
        .contextMenu(forSelectionType: Item.ID.self) { items in
            if items.isEmpty { // Empty
                Button("New Item") { }
            } else if items.count == 1 { // Sigle item menu
                Button("Copy") { }
                Button("Delete", role: .destructive) { }
            } else { // Multi-item menu.
                Button("Copy") { }
                Button("New Folder With Selection") { }
                Button("Delete Selected", role: .destructive) { }
            }
        }
        .toolbar(content: {
            EditButton()
        })
    }

    struct Item: Identifiable {
        let id = UUID()

        let name: String
    }
}
