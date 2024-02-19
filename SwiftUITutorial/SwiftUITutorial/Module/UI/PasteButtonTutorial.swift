//
//  PasteButtonTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/19.
//

import SwiftUI

/*
 A system button that reads items from the pasteboard and delivers it to a closure.

 Use a paste button when you want to provide a button for pasting items from the system pasteboard into your app. The system provides a button appearance and label appropriate to the current environment. However, you can use view modifiers like buttonBorderShape(_:), labelStyle(_:), and tint(_:) to customize the button in some contexts.

 就是用户读取系统粘贴板的数据的按钮。
 */
struct PasteButtonTutorial: View {

    @State private var pastedTest = ""

    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {

            Text(pastedTest)
            PasteButton(payloadType: String.self) { strings in
                pastedTest = strings[0]
            }
            .tint(.red)
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    PasteButtonTutorial()
}
