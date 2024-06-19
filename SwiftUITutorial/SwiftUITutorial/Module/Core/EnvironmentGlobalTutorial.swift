//
//  EnvironmentGlobalTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/4/12.
//

import SwiftUI

struct EnvironmentGlobalTutorial: View {

    @Environment(\.calendar) private var calendar

    var body: some View {
        List {
            Button("Calendar") {
                
            }
        }
    }
}

#Preview {
    EnvironmentGlobalTutorial()
}
