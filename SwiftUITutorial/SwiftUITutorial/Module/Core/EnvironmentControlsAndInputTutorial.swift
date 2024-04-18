//
//  EnvironmentControlsAndInputTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/4/12.
//

import SwiftUI

struct EnvironmentControlsAndInputTutorial: View {

    // MARK: - system
    var body: some View {
        VStack {
            Button("Button") {
                print("---Button---")
            }
            .buttonRepeatBehavior(.enabled)

            ControlsAndInputConent()
        }
    }
}

struct ControlsAndInputConent: View {
    @Environment(\.buttonRepeatBehavior) var buttonRepeatBehavior
    @Environment(\.controlSize) var controlSize
    @Environment(\.searchSuggestionsPlacement) var searchSuggestionsPlacement
    @Environment(\.menuIndicatorVisibility) var menuIndicatorVisibility
    @Environment(\.menuOrder) var menuOrder

    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {

            Button("ButtonRepeatBehavior") {
                print(buttonRepeatBehavior)
            }

            Button("ControlSize") {
                print(controlSize)
            }

            Button("SearchSuggestionsPlacement") {
                print(searchSuggestionsPlacement)
            }

            Button("MenuIndicatorVisibility") {
                print(menuIndicatorVisibility)
            }

            Button("MenuOrder") {
                print(menuOrder)
            }
        }
    }
}

#Preview {
    EnvironmentControlsAndInputTutorial()
}
