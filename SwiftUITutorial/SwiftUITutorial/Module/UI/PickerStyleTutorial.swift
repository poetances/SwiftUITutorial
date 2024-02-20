//
//  PickerStyleTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/20.
//

import SwiftUI

/*
 PickerStyle样式：

 DefaultPickerStyle
 InlinePickerStyle
 MenuPickerStyle
 NavigationLinkPickerStyle
 PalettePickerStyle
 PopUpButtonPickerStyle
 RadioGroupPickerStyle
 SegmentedPickerStyle
 WheelPickerStyle
 */
struct PickerStyleTutorial: View {
    
    @State private var selection = 0

    // MARK: - system
    var body: some View {

        VStack(spacing: 15) {

            Picker("Picker", selection: $selection) {
                Text("One").tag(0)
                Text("Two").tag(1)
            }
            .pickerStyle(.menu)

            Picker(selection: $selection) {
                Text("One").tag(0)
                Text("Two").tag(1)
            } label: {
                Label("Text\(selection)", systemImage: "square.and.pencil")
            }
            .pickerStyle(.segmented)

            Menu("PDF") {
                Button("Open in Preview", action: openInPreview)
                Button("Save as PDF", action: saveAsPDF)
            }
            .menuStyle(.borderlessButton)
        }
    }

    func openInPreview() {

    }

    func saveAsPDF() {

    }
}

#Preview {
    PickerStyleTutorial()
}
