//
//  WindowTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/1/24.
//

import SwiftUI

struct WindowTutorial: View {
    @Environment(\.supportsMultipleWindows) private var supportsMultipleWindows
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.dismiss) private var dismiss

    @State private var isPresented = false

    // MARK: - sysmtem
    var body: some View {
        Text("SupportsMultipleWindows: \(supportsMultipleWindows ? "true":"false")").padding()

        Button("OpenWindow") {
            if supportsMultipleWindows {
                openWindow(id: "two")
            }
        }.padding()

        Button("CloseWindow") {
            if supportsMultipleWindows {
                dismissWindow(id: "two")
            }
        }.padding()

        Button("dismiss") {
            /*
             You can use this action to:
             Dismiss a modal presentation, like a sheet or a popover.
             Pop the current view from a NavigationStack.
             Close a window that you create with WindowGroup or Window.
             */
            dismiss() // Implicitly calls dismiss.callAsFunction()
        }.padding()

        Button("Present") {
            isPresented.toggle()
        }.sheet(isPresented: $isPresented, content: {
            PresentedView()
        }).padding()

        Button("CloseWindow") {
            // DismissBehavior
            withTransaction(\.dismissBehavior, .destructive) {
                dismissWindow(id: "auxiliary")
            }
        }

    }
}

#Preview {
    WindowTutorial()
}


struct PresentedView: View {
    @Environment(\.dismiss) private var dismiss

    // MARK: - system
    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}
