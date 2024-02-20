//
//  ToggleTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/19.
//

import SwiftUI

/*

 Toggle唯一需要注意的一个点有一个modifier，toggleStyle(_:)
 
 ToggleStyle一个协议：
 static var button: ButtonToggleStyle { get }
 static var checkbox: CheckboxToggleStyle { get }
 static var `switch`: SwitchToggleStyle

 ButtonToggleStyle
 CheckboxToggleStyle
 DefaultToggleStyle
 SwitchToggleStyle
 */
struct ToggleTutorial: View {

    @State private var isOn = false

    @State private var alarms = [
        Alarm(isOn: true, name: "Morning"),
        Alarm(isOn: false, name: "Evening")
    ]

    // MARK: - system
    var body: some View {

        VStack(spacing: 15) {
            Toggle("Toggle", isOn: $isOn)

            Toggle(isOn: $isOn) {
                Label("Lable", systemImage: "pencil")
            }

            Toggle("Sources", sources: $alarms, isOn: \.isOn)
        }
        .toggleStyle(.switch)
        .padding()
    }

    struct Alarm: Hashable, Identifiable {

        let id = UUID()

        var isOn = false

        var name = ""
    }
}

#Preview {
    ToggleTutorial()
}
