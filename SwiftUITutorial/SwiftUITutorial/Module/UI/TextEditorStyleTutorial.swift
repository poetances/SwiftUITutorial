//
//  TextEditorStyleTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/22.
//

import SwiftUI

/*
 TextEditorStyle

 AutomaticTextEditorStyle
 PlainTextEditorStyle
 RoundedBorderTextEditorStyle visionOS 1.0+ Beta
 */
struct TextEditorStyleTutorial: View {

    @State private var text = ""
    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {
            TextEditor(text: $text)
                .textEditorStyle(.plain)
                .padding()
                .border(.red)

            TextEditor(text: $text)
                .textEditorStyle(.automatic)
                .padding()
                .border(.red)

        }
        .padding()
    }
}

#Preview {
    TextEditorStyleTutorial()
}
