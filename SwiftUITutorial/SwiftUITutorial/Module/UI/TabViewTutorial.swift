//
//  TabViewTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/1/25.
//

import SwiftUI

/*
TabView，苹果也归类于Navigation，考虑到排版，单独拎出来
 */
struct TabViewTutorial: View {
    
    @State private var index = 1

    // MARK: - system
    var body: some View {
        Label("Label", systemImage: "list.dash")

        tabview_normal
        List {
            Text("Recents")
               .badge(index)
            Text("Selection Index \(index)")
        }
        tabview_selection
        Divider()
        tabview_style
            .toolbar(.hidden, for: .tabBar)
    }
}

// MARK: - init(content:)
extension TabViewTutorial {

    var tabview_normal: some View {
        TabView {
            Text("One")
                .background(Color.purple)
                .badge(1)
                .tabItem {
                    Label("one", systemImage: "list.dash")
                }
            Text("Two")
                .background(Color.purple)
                .tabItem {
                    Label("Two", systemImage: "tray.and.arrow.up.fill")
                }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}

// MARK: - init(selection:content:)
extension TabViewTutorial {

    var tabview_selection: some View {
        TabView(selection: $index) {
            Text("scribble")
                .tabItem {
                    Label("scribble", systemImage: "scribble")
                }
                .tag(0)


            Text("eraser")
                .tabItem {
                    Label("eraser", systemImage: "eraser.fill")
                }
                .tag(1)


            Text("paperplane")
                .tabItem {
                    Label("paperplane", systemImage: "paperplane")
                }
                .tag(2)
                .badge(2)
        }
    }
}

// MARK: - tabViewStyle(_:)
extension TabViewTutorial {

    var tabview_style: some View {
        TabView {
            Text("tray")
                .tabItem {
                    Label("tray", systemImage: "tray")
                }

            Text("externaldrive")
                .tabItem {
                    Label("externaldrive", systemImage: "externaldrive")
                }

            Text("xmark")
                .tabItem {
                    Label("xmark", systemImage: "xmark.bin")
                }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

// MARK: - modifier
extension TabViewTutorial {

    /*
     badge(_ count: Int)
     tag<V>(_ tag: V)
     tabItem(_:)
     tabViewStyle(_:)
     */
}

#Preview {
    TabViewTutorial()
}
