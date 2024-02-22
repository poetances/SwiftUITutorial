//
//  TextFieldStyleTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/21.
//

import SwiftUI

/*
 TextFieldStyle：
 DefaultTextFieldStyle
 PlainTextFieldStyle
 RoundedBorderTextFieldStyle
 SquareBorderTextFieldStyle macos
 */
struct TextFieldStyleTutorial: View {

    @State private var text = ""

    var body: some View {
        VStack(spacing: 15) {
            TextField("placeholder", text: $text)
                .textFieldStyle(.plain)

            TextField("placeholder", text: $text)
                .textFieldStyle(.roundedBorder)
        }
        .padding()
        .font(.title2)
    }
}

#Preview {
    TextFieldStyleTutorial()
}
