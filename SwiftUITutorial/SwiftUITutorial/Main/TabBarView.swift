//
//  TabBarView.swift
//  SwiftUITutorial
//
//  Created by zcj on 2023/12/1.
//

import SwiftUI

struct TabBarView: View {
    @AppStorage("selectionTabViewIndex") private var index: Index = .core

    var body: some View {
        TabView(selection: $index) {
            Group {
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


                FoundationPage()
                    .tabItem {
                        TabBarItem(title: "Foundation", image: "arrow.3.trianglepath")
                    }
                    .tag(Index.foundation)

                LeetCodePage()
                    .tabItem {
                        TabBarItem(title: "LeeCode", image: "globe.americas.fill")
                    }
                    .tag(Index.leeCode)
            }
            // .toolbarBackground(Color.blue, for: .tabBar)
            // .toolbar(.visible, for: .tabBar)
        }
    }
}

extension TabBarView {

    enum Index: Int {
        case core, ui, foundation, leeCode
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
