//
//  ConfiguringSeperatorsTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/3/1.
//

import SwiftUI

/*
 listRowSeparatorTint(_:edges:)
 listSectionSeparatorTint(_:edges:)
 listRowSeparator(_:edges:)
 listSectionSeparator(_:edges:)
 */
struct ConfiguringSeperatorsTutorial: View {
    var body: some View {
        List {
            Section("Secontion1") {
                ForEach(0 ..< 10) { index in
                    Text("Item \(index)")
                }
                .listRowSeparator(.hidden)
            }
            .listSectionSeparator(.hidden)
            .headerProminence(.standard)

            Section {
                ForEach(10 ..< 20) { index in
                    Text("Item \(index)")
                }
                .listRowSeparatorTint(.red, edges: .all)
            } footer: {
                Text("Footer2")
            }
            .listSectionSeparatorTint(.red, edges: .all)
            .listSectionSeparator(.hidden, edges: .all)

            Section {
                ForEach(20 ..< 30) { index in
                    Text("Item \(index)")
                }
                .listRowSeparatorTint(.indigo)
            } header: {
                Text("Header3")
            } footer: {
                Text("Footer3")
            }
        }
        .listStyle(.plain)
        .headerProminence(.standard)
    }
}

#Preview {
    ConfiguringSeperatorsTutorial()
}
