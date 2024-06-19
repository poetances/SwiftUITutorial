//
//  CreatingViewTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/4/18.
//

import SwiftUI

/*
 protocol View
 var body: Self.Body
 func modifier<T>(T) -> ModifiedContent<Self, T>
 */
struct CreatingViewTutorial: View {
    var body: some View {
        List(Destination.allCases, id: \.rawValue) { destination in
            NavigationLink(destination.rawValue.lowercased(), value: destination)
        }
        .navigationTitle("CreatingView")
        .navigationDestination(for: Destination.self) { des in
            switch des {
            case .appearanceModifiers:
                AppearanceModifiersTutorail()
            }
        }

    }
}

extension CreatingViewTutorial {

    enum Destination: String, CaseIterable {
        case appearanceModifiers
    }
}

#Preview {
    CreatingViewTutorial()
}
