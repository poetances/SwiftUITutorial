//
//  ConcurrencyPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/3/4.
//

import SwiftUI

struct ConcurrencyPage: View {

    // MARK: - system
    var body: some View {

        List(Destination.allCases, id: \.rawValue) {
            NavigationLink($0.rawValue.capitalized, value: $0)
        }
        .navigationDestination(for: Destination.self) { des in
            switch des {
            case .tasks:
                TasksTutorial()
            case .asyncSequences:
                AsyncSequencesTutorial()
            case .continuations:
                ContinuationsTutorial()
            case .actors:
                ActorsTutorial()
            case .taskLocal:
                TaskLocalTutorial()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

extension ConcurrencyPage {

    enum Destination: String, CaseIterable {
        case tasks
        case asyncSequences
        case continuations
        case actors
        case taskLocal
    }
}

#Preview {
    ConcurrencyPage()
}
