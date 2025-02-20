//
//  AlertToastPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/9/24.
//

import SwiftUI
import AlertToast

struct AlertToastPage: View {
    @State private var showToast = false

    var body: some View {
        List {
            Button("Alter") {
                showToast.toggle()
            }
        }
        .toast(isPresenting: $showToast) {
            AlertToast(displayMode: .alert, type: .regular, title: "Alter Error")
        }
    }
}


#Preview {
    AlertToastPage()
}
