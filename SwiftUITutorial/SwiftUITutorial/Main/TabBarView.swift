//
//  TabBarView.swift
//  SwiftUITutorial
//
//  Created by zcj on 2023/12/1.
//

import SwiftUI

struct TabBarView: View {
    @State private var index: Index = .core

    var body: some View {
        TabView(selection: $index) {
            CorePage()
                .tabItem {
                    TabBarItem(title: "Core", image: "arrow.up.arrow.down.square")
                }
                .tag(Index.core)

            UIPage()
                .tabItem {
                    TabBarItem(title: "UI", image: "magnifyingglass.circle.fill")
                }
                .tag(Index.ui)


            CombinePage()
                .tabItem {
                    TabBarItem(title: "Combine", image: "arrow.3.trianglepath")
                }
                .tag(Index.combine)
        }
    }
}

extension TabBarView {

    enum Index: Int {
        case core, ui, combine
    }
}

#Preview {
    TabBarView()
}


struct TabBarItem: View {
    let title: String
    let image: String

    var body: some View {
        VStack {
            Image(systemName: image)
                .imageScale(.large)
            Text(title)
        }
    }
}
