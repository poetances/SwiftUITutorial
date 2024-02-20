//
//  ColorPickerTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/20.
//

import SwiftUI

struct ColorPickerTutorial: View {
    
    @State private var selection: Color = .red
    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {
            ColorPicker("ColorPicker", selection: $selection)
                .foregroundStyle(selection)

            ColorPicker(selection: $selection, supportsOpacity: false, label: {
                Label("ColorPicker", systemImage: "pencil.circle")
            })
        }
        .padding()
    }
}

#Preview {
    ColorPickerTutorial()
}
