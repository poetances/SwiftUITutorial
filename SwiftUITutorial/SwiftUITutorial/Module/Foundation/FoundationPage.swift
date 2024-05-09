//
//  FoundationPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/1/31.
//

import SwiftUI

struct FoundationPage: View {

    private var dataSouces: [Content] = [
        Content("Combine", .combine),
        Content("Observation", .observation),
        Content("Concurrency", .concurrency)
    ]

    // MARK: - system
    var body: some View {
        NavigationStack {
            List(dataSouces) { data in
                NavigationLink(data.title, value: data.destination)
            }
            .navigationTitle("Foundation")
            .navigationDestination(for: Destination.self) { des in
                switch des {
                case .combine:
                    CombinePage()
                case .observation:
                    ObservationTutorial()
                case .concurrency:
                    ConcurrencyPage()
                }
            }
        }
    }
}

extension FoundationPage {

    enum Destination {
        case combine
        case observation
        case concurrency
    }

    struct Content: Identifiable {
        let id = UUID()
        let title: String
        let destination: Destination

        init(_ title: String, _ destination: Destination) {
            self.title = title
            self.destination = destination
        }
    }
}

#Preview {
    FoundationPage()
}
