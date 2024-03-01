//
//  ListStyleTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/3/1.
//

import SwiftUI

struct ListStyleTutorial: View {

    // MARK: - system
    var body: some View {
        List {
            Section("One") {
                ForEach(0 ..< 10) { index in
                    Text("Item \(index)")
                }
            }



            Section("Two") {
                ForEach(0 ..< 10) { index in
                    Text("Item \(index)")
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    ListStyleTutorial()
}
