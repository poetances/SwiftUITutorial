//
//  ProgressViewStyleTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/21.
//

import SwiftUI

/*
 ProgressViewStyle

 CircularProgressViewStyle
 DefaultProgressViewStyle
 LinearProgressViewStyle
 */
struct ProgressViewStyleTutorial: View {
    var body: some View {
        VStack(spacing: 15) {
            ProgressView()
                .progressViewStyle(.circular)

            ProgressView(value: 10, total: 100)
                .progressViewStyle(.linear)

            ProgressView("ProgressView", value: 10, total: 100)
        }
        .padding()
    }
}

#Preview {
    ProgressViewStyleTutorial()
}
