//
//  AppearanceModifiersTutorail.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/6/19.
//

import SwiftUI

struct AppearanceModifiersTutorail: View {
    var body: some View {
        ScrollView {
            Image(systemName: "swift")
                .padding()
                .background(in: .ellipse)
                .padding()
                .backgroundStyle(.blue.gradient)

        }
        .navigationTitle("AppearanceModifiers")
    }
}

#Preview {
    AppearanceModifiersTutorail()
}
