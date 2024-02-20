//
//  ControlSizeTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/20.
//

import SwiftUI

/*
 ControlSize一个枚举
 The size classes, like regular or small, that you can apply to controls within a view.

 */
struct ControlSizeTutorial: View {

    @State private var value = 0.0

    var body: some View {
        VStack(spacing: 15) {
            
            Slider(value: $value, in: 0...10)
                .controlSize(.small)

            Slider(value: $value)
                .controlSize(.large)

            ProgressView().controlSize(.small)

            ProgressView().controlSize(.large)
        }
        .padding()
    }
}

#Preview {
    ControlSizeTutorial()
}
