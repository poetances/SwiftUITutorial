//
//  StoragePage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/4/16.
//

import SwiftUI

struct StoragePage: View {
    var body: some View {
        List(Destination.allCases, id: \.rawValue) { des in
            NavigationLink(des.rawValue.capitalized, value: des)
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("Storage")
        .navigationDestination(for: Destination.self) { des in
            switch des {
            case .appStorage:
                AppStorageTutorial()
            case .sceneStorage:
                SceneStorageTutorial()
            }
        }
    }
}

extension StoragePage {

    enum Destination: String, CaseIterable {
        case appStorage
        case sceneStorage
    }
}

#Preview {
    StoragePage()
}
