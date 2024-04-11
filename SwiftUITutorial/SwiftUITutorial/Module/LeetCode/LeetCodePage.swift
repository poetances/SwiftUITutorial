//
//  LeetCodePage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/3/28.
//

import SwiftUI

struct LeetCodePage: View {

    var body: some View {
        NavigationStack {
            List(Destination.allCases, id: \.rawValue) { des in
                NavigationLink(des.rawValue.capitalized, value: des)
            }
            .navigationTitle("LeeCode")
            .navigationDestination(for: Destination.self) { des in
                switch des {
                case .array:
                    LeetcodeArrayTutorial()
                }
            }
        }
    }
}

extension LeetCodePage {

    enum Destination: String, CaseIterable {
        case array
    }
}

#Preview {
    LeetCodePage()
}
