//
//  ModelDataPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/4/12.
//

import SwiftUI

struct ModelDataPage: View {

    // MARK: - system
    var body: some View {

        List(Destination.allCases, id: \.rawValue) { des in
            NavigationLink(des.rawValue.capitalized, value: des)
        }
        .navigationTitle("ModelData")
        .toolbar(.hidden, for: .tabBar)
        .navigationDestination(for: Destination.self) { des in
            switch des {
            case .state:
                StateObjectTutorial()
            case .modelData:
                ModelDataTutorial()
            case .binding:
                BindingTutorial()
            }
        }
    }
}

extension ModelDataPage {

    enum Destination: String, CaseIterable {

        case state
        case modelData
        case binding
    }
}

#Preview {
    ModelDataPage()
}
