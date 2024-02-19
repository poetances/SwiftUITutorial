//
//  EditButtonTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/19.
//

import SwiftUI

/*
 EditButton，一般用于List中，用户处理列表的移动、删除。
 */
struct EditButtonTutorial: View {

    @State private var fruits = [
        "Apple",
        "Banana",
        "Papaya",
        "Mango"
    ]
    // MARK: - system
    var body: some View {
        List {
            ForEach(fruits, id: \.self) { fruit in
                Text(fruit)
            }
            .onDelete { fruits.remove(atOffsets: $0) }
            .onMove { fruits.move(fromOffsets: $0, toOffset: $1) }
        }
        .navigationTitle("Fruits")
        .toolbar { EditButton() }

    }
}

#Preview {
    EditButtonTutorial()
}
