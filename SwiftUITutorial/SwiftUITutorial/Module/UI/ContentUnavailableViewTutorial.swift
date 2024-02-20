//
//  ContentUnavailableViewTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/20.
//

import SwiftUI

/*
 ContentUnavailableView很简单，提供了一种内容空白的展示方式。

 以Image、title、actions的形式展示。

 SearchUnavailableContent
 You don’t create this type directly. SwiftUI creates it when you build a searchContentUnavailableView.

 也就是如果内容为空时候，用该struct去绘制View。
 */
struct ContentUnavailableViewTutorial: View {
    var body: some View {
        VStack(spacing: 15) {
            ContentUnavailableView("标题", systemImage: "eraser.line.dashed", description: Text("eraser.line.dashed"))

            ContentUnavailableView(label: {
                Label("No Mail", systemImage: "tray.fill")
            }, actions:  {
                Button("Retry") {

                }
                Button("Other") {

                }
            })

            ContentUnavailableView.search
        }
        .padding()
    }
}

#Preview {
    ContentUnavailableViewTutorial()
}
