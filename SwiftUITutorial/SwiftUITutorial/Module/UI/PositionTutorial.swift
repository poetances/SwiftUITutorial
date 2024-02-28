//
//  PositionTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/28.
//

import SwiftUI

/*
 position(_:)
 offset(_:)
 主要两个方法
 */
struct PositionTutorial: View {
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .stroke(Color.primary)
                Image(systemName: "circle")
                    .offset(x: 50)
            }
            .frame(width: 160, height: 160)

            ZStack {
                Rectangle()
                    .stroke(Color.primary)
                Image(systemName: "circle")
                    .position(x: 144, y: 80)
            }
            .frame(width: 160, height: 160)
        }
    }
}

#Preview {
    PositionTutorial()
}
