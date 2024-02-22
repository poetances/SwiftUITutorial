//
//  TextEditorTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/21.
//

import SwiftUI

/*
 相比TextField增加了滚动条
 */
struct TextEditorTutorial: View {

    @State private var text = ""
    // MARK: - system
    var body: some View {
        TextEditor(text: $text)
            .padding()
            .border(.red)
            .frame(height: 100)
    }
}

#Preview {
    TextEditorTutorial()
}
