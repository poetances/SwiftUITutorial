//
//  ViewFundamentalsPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/4/18.
//

import SwiftUI

struct ViewFundamentalsPage: View {
    var body: some View {
        List(Destination.allCases, id: \.rawValue) { des in
            NavigationLink(des.rawValue.capitalized, value: des)
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("ViewFundamentals")
        .navigationDestination(for: Destination.self) { des in
            switch des {
            case .creatingView:
                CreatingViewTutorial()
            case .modifyView:
                ModifyViewTutorial()
            }
        }
    }
}

extension ViewFundamentalsPage {
 
    enum Destination: String, CaseIterable {
        case creatingView
        case modifyView
    }
}

#Preview {
    ViewFundamentalsPage()
}
