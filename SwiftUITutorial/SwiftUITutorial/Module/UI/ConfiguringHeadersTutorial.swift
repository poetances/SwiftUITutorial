//
//  ConfiguringHeadersTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/3/1.
//

import SwiftUI

/*
 headerProminence(_:)

 Prominence
 case standard
    The standard prominence.
 case increased
    An increased prominence.
 */
struct ConfiguringHeadersTutorial: View {

    var body: some View {
        List {
            Section("Header") {
                ForEach(0 ..< 10) { index in
                    Text("Item \(index)")
                }
            }
            .headerProminence(.increased)

            Section("Header") {
                ForEach(10 ..< 20) { index in
                    Text("Item \(index)")
                }
            }
            .headerProminence(.standard)
        }
    }
}

#Preview {
    ConfiguringHeadersTutorial()
}
