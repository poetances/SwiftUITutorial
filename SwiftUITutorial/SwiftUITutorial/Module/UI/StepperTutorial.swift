//
//  StepperTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/19.
//

import SwiftUI

struct StepperTutorial: View {

    @State private var value = 0
    let colors: [Color] = [
        .orange, .red, .gray, .blue,
        .green, .purple, .pink
    ]

    // MARK: - system
    var body: some View {

        VStack(spacing: 15) {
            Stepper("Stepper \(value)", value: $value) { isEditing in
                print(isEditing)
            }

            Stepper("Stepper step \(value)", value: $value, step: 5)

            Stepper("Stepper in \(value)", value: $value, in: 0...100, step: 5)

            Stepper("Stepper increment \(value)") {
                increment()
            } onDecrement: {
                decrement()
            }

            Stepper {
                Text("Value: \(value) Color: \(colors[value].description)")
            } onIncrement: {
                increment()
            } onDecrement: {
                decrement()
            }
            .padding(5)
            .background(colors[value])

        }
        .padding()
    }

    func increment() {
        value += 1
        if value >= colors.count { value = 0 }
    }

    func decrement() {
        value -= 1
        if value < 0 { value = colors.count - 1 }
    }
}

#Preview {
    StepperTutorial()
}
