//
//  MarginTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/28.
//

import SwiftUI

/*
 contentMargins(_:for:)

 ContentMarginPlacement
 static var automatic: ContentMarginPlacement
    The automatic placement.
 static var scrollContent: ContentMarginPlacement
    The scroll content placement.
 static var scrollIndicators: ContentMarginPlacement
    The scroll indicators placement.

 根据内容展示我们就知道，contentMargins并不类似Flutter中的margin，它修饰的scrollContent、scrllIndicator。
 所以前提是有ScrollView，所以TextField、Text等，会发现没有效果。
 */
struct MarginTutorial: View {

    @State private var text = "text"

    // MARK: - system
    var body: some View {
        VStack {
            TextField("", text: $text, prompt: Text("Placeholder"))
                .contentMargins(.horizontal, 20.0, for: .scrollContent) // 不会起作用

            TextEditor(text: $text)
                .frame(height: 100)
                .contentMargins(.horizontal, 20.0, for: .scrollContent)

            ScrollView {
                ForEach(0..<50) { i in
                    Text("Item \(i)")
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .foregroundStyle(.white)
                }
            }
            .contentMargins(.top, 30, for: .scrollContent)

            ScrollView {
                ForEach(0..<50) { i in
                    Text("Item \(i)")
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .foregroundStyle(.white)
                }
            }
            .contentMargins(.top, 100, for: .scrollIndicators)
        }
        .padding()
    }
}

#Preview {
    MarginTutorial()
}
