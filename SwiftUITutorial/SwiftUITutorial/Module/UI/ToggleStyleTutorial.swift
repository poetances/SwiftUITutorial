//
//  ToggleStyleTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/21.
//

import SwiftUI

/*
 ToggleStyle

 ButtonToggleStyle
 CheckboxToggleStyle macos
 DefaultToggleStyle
 SwitchToggleStyle
 */
struct ToggleStyleTutorial: View {

    @State private var isOn = false
    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {
            Toggle("Switch", isOn: $isOn)
                .toggleStyle(.switch)

            Toggle("Button", isOn: $isOn)
                .toggleStyle(.button)

        }.padding()
    }
}

#Preview {
    ToggleStyleTutorial()
}
