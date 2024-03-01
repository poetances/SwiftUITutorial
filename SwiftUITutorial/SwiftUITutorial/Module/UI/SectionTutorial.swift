//
//  SectionTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/29.
//

import SwiftUI

/*
 struct Section<Parent, Content, Footer>

 Use Section instances in views like List, Picker, and Form to organize content into separate sections. Each section has custom content that you provide on a per-instance basis. You can also provide headers and footers for each section.

 所以一般常见用于List、Picker、Form。
 */
struct SectionTutorial: View {

    @State private var isExpand = false
    // MARK: - system
    var body: some View {
        List {
            Section("Parent") {
                ForEach(0 ..< 10) { index in
                    Text("Item \(index)")
                }
            }

            Section {
                ForEach(0 ..< 10) { index in
                    Text("Item \(index)")
                }
            } footer: {
                Text("Footer")
                    .frame(height: 46)
            }

            Section {
                ForEach(0 ..< 10) { index in
                    Text("Item \(index)")
                }
            } header: {
                Text("Header")
            } footer: {
                Text("Footer")
            }

            Section(isExpanded: $isExpand) {
                ForEach(0 ..< 10) { index in
                    Text("Item \(index)")
                }
            } header: {
                Button("Expand") {
                    isExpand.toggle()
                }
            }
        }
        .listStyle(.plain)
    }

}

#Preview {
    SectionTutorial()
}
