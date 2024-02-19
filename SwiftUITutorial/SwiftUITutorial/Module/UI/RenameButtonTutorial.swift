//
//  RenameButtonTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/19.
//

import SwiftUI

/*
 A button that triggers a standard rename action.
 也就是可以触发系统的重命名事件。
 */
struct RenameButtonTutorial: View {

    @State private var text = ""
    @FocusState private var isFocus: Bool
    // MARK: - system
    var body: some View {
        TextField(text: $text) {
            Text("Prompt")
        }
        .focused($isFocus)
        .contextMenu {
            RenameButton()
        }
        .renameAction { isFocus = false }
        .padding()
        .navigationTitle("Title")

        RenameButton()
    }
}

#Preview {
    RenameButtonTutorial()
}
