//
//  AppearanceModifiersTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/6.
//

import SwiftUI

struct AppearanceModifiersTutorial: View {
    var body: some View {
        backgroundStyle
        foregroundStyle
    }
}

// MARK: - Colors and patterns
extension AppearanceModifiersTutorial {

    var backgroundStyle: some View {
        Image(systemName: "swift")
            .padding()
            .background(in: Circle())
            .backgroundStyle(.blue.gradient)
            .foregroundStyle(.pink)
    }

    var foregroundStyle: some View {
        HStack {
            Image(systemName: "arrowshape.up.circle.fill")
            Text("Hello, SwiftUI")
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 40, height: 20)
        }
        .foregroundStyle(.teal)
    }
}



#Preview {
    AppearanceModifiersTutorial()
}
