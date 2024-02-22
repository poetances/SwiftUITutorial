//
//  LabelStyleTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/21.
//

import SwiftUI

/*
 LabelStyle

 DefaultLabelStyle
 IconOnlyLabelStyle
 TitleAndIconLabelStyle
 TitleOnlyLabelStyle
 */
struct LabelStyleTutorial: View {
    var body: some View {
        VStack(spacing: 15) {
            Label("Fire", systemImage: "flame.fill")
                .labelStyle(.iconOnly)

            Label("Lightning", systemImage: "bolt.fill")
                .labelStyle(.titleOnly)

            VStack(content: {
                Label("Fire", systemImage: "flame.fill")

                Label("Lightning", systemImage: "bolt.fill")
            })
            .labelStyle(.iconOnly)
        }
    }
}

#Preview {
    LabelStyleTutorial()
}
