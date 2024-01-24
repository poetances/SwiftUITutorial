//
//  CorePage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2023/12/1.
//

import SwiftUI

struct CorePage: View {

    @EnvironmentObject private var appDelegate: SwiftUIAppDelegate

    @State private var index = 0

    var body: some View {
        NavigationView {
            ScrollView {
                Button("AddIndex") {
                    index += 1
                }
                LazyVStack(spacing: 20) {
                    NavigationLink("StateObject") {
                        StateObjectTutorial()
                    }
                    NavigationLink("PropertyWrapper") {
                        PropertyWrapperTutorial()
                    }
                    NavigationLink("ResultBuilder") {
                        ResultBuildTutorial()
                    }
                    NavigationLink("RenderLoop") {
                        RenderLoopTutorail()
                    }
                    NavigationLink("Macro") {
                        SwiftMacroTutorail()
                    }
                    NavigationLink("AttibutedString") {
                        AttributedStringTutorial()
                    }
                }
            }
            .navigationTitle("CorePage\(index)")
        }
    }
}

#Preview {
    CorePage()
}
