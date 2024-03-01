//
//  DisclosureGroupTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/3/1.
//

import SwiftUI

/*
 struct DisclosureGroup<Label, Content> where Label : View, Content : View
 A view that shows or hides another content view, based on the state of a disclosure control.

 我们可以很容易联想到Section就是基于DisclosureGroup实现的

 DisclosureGroupStyle可以用于样式的自定义
 */
struct DisclosureGroupTutorial: View {

    @State private var toggleStates = ToggleStates()
    @State private var topExpanded: Bool = true
    
    // MARK: - system
    var body: some View {
        DisclosureGroup("Items", isExpanded: $topExpanded) {
            Toggle("Toggle 1", isOn: $toggleStates.oneIsOn)
            Toggle("Toggle 2", isOn: $toggleStates.twoIsOn)
            DisclosureGroup("Sub-items") {
                Text("Sub-item 1")
            }
        }
        .disclosureGroupStyle(MyDisclosureStyle())
        .border(Color.red)
        .padding()
    }

    struct ToggleStates {
        var oneIsOn: Bool = false
        var twoIsOn: Bool = true
    }


    // 自定义样式
    struct MyDisclosureStyle: DisclosureGroupStyle {
        func makeBody(configuration: Configuration) -> some View {
            VStack {
                Button {
                    withAnimation {
                        configuration.isExpanded.toggle()
                    }
                } label: {
                    HStack(alignment: .firstTextBaseline) {
                        configuration.label
                        Spacer()
                        Text(configuration.isExpanded ? "hide" : "show")
                            .foregroundColor(.accentColor)
                            .font(.caption.lowercaseSmallCaps())
                            .animation(nil, value: configuration.isExpanded)
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                if configuration.isExpanded {
                    configuration.content
                }
            }
        }
    }
}

#Preview {
    DisclosureGroupTutorial()
}
