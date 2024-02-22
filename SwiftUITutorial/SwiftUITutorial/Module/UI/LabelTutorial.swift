//
//  LabelTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/21.
//

import SwiftUI

/*
 Label就是：Image+Label

 LabelStyle样式
 DefaultLabelStyle
 IconOnlyLabelStyle
 TitleAndIconLabelStyle
 TitleOnlyLabelStyle
 */
struct LabelTutorial: View {
    var body: some View {
        VStack(spacing: 15) {

            Label("Label", systemImage: "pencil.tip.crop.circle.fill")

            Label(
                title: { Text("Label") },
                icon: { Image(systemName: "42.circle") }
            )

            Label("Label", systemImage: "pencil.tip.crop.circle.fill")
                .labelStyle(.iconOnly)
            Label("Label", systemImage: "pencil.tip.crop.circle.fill")
                .labelStyle(.titleOnly)
        }
    }
}

#Preview {
    LabelTutorial()
}
