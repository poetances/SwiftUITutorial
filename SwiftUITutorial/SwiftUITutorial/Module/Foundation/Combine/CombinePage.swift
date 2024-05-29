//
//  CombinePage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/7.
//

import SwiftUI

struct CombinePage: View {
    var body: some View {
        List(Destination.allCases, id: \.rawValue) { des in
            NavigationLink(des.rawValue.capitalized, value: des)
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("CombinePage")
        .navigationDestination(for: Destination.self) { des in
            switch des {
            case .publisher:
                PublisherPage()
            case .published:
                PublishedTutorial()
            case .cancelable:
                CancelableTutorial()
            case .subscribers:
                SubscribersTutorial()
            case .subscriptions:
                SubscriptionsTutorial()
            case .convincePublisher:
                ConvincePublisherTutorial()
            case .subject:
                SubjectsTutorial()
            }
        }
    }
}

extension CombinePage {

    enum Destination: String, CaseIterable {
        case publisher
        case published
        case cancelable
        case subscribers
        case subscriptions
        case convincePublisher
        case subject
    }
}

#Preview {
    CombinePage()
}
