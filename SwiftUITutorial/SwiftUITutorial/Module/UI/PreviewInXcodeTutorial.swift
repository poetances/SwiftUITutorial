//
//  PreviewInXcodeTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/6.
//

import SwiftUI

struct PreviewInXcodeTutorial: View {
    var body: some View {
        Text("Hello, World!")
    }
}

// Previe
#Preview {
    PreviewInXcodeTutorial()
}

#Preview(traits: .landscapeRight, body: {
    ViewFundamentalsPage()
})
