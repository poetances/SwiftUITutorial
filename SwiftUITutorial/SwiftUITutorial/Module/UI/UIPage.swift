//
//  UIPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2023/12/1.
//

import SwiftUI

struct UIPage: View {
    private let dataSources = [
        "Picker"
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                NavigationLink("App") {
                    AppTutorial()
                }.padding()

                NavigationLink("Scene") {
                    SceneTutorail()
                }
            }
        }
    }
}

#Preview {
    UIPage()
}
