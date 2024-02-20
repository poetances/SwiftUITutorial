//
//  SlideTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/19.
//

import SwiftUI

struct SlideTutorial: View {

    @State private var value = 0.0
    @State private var isEditing = false

    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {
            Text("\(value)")
                .foregroundStyle(isEditing ? Color.red : Color.blue)
            Slider(value: $value, in: 0...100) { isEditing = $0 }

            Slider(value: $value, in: 0...100, step: 5)  { isEditing = $0 }

            Slider(value: $value, in: 0...100) {
                Text("Lable")
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("100")
            }
        }
        .padding()
    }
}

#Preview {
    SlideTutorial()
}
