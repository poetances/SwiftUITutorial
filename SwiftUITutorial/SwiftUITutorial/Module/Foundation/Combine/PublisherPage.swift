//
//  PublisherPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/8.
//

import SwiftUI
import Combine

extension Combine.Publisher {

    func sinkAutoPrint() -> AnyCancellable {
        return self.sink { cp in
            Swift.print("completion", cp)
        } receiveValue: { value in
            Swift.print("receive value", value)
        }
    }
}

/*
 protocol Publisher<Output, Failure>
 func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input


 这两个方法是用来调用的
 func subscribe<S>(_ subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input
 func subscribe<S>(_ subject: S) -> AnyCancellable where S : Subject, Self.Failure == S.Failure, Self.Output == S.Output

 这是解释
 Always call this function instead of receive(subscriber:). Adopters of Publisher must implement receive(subscriber:). The implementation of subscribe(_:) provided by Publisher calls through to receive(subscriber:).
 */
struct PublisherPage: View {
    var body: some View {
        List(Destination.allCases, id: \.rawValue) { des in
            NavigationLink(des.rawValue.capitalized, value: des)
        }
        .navigationTitle("Publisher")
        .navigationDestination(for: Destination.self) { des in
            switch des {
            case .custom:
                CustomPubliserTutorial()
            case .mapping:
                MappingTutorial()
            case .filtering:
                FilteringTutorial()
            case .reducing:
                ReducingTutorial()
            case .mathematic:
                MathematicOperatorTutorial()
            case .matching:
                MatchingTutorial()
            case .sequenceOperator:
                SequenceOperatorTutorial()
            case .specificElement:
                SpecificElementTutorial()
            case .multiplePublisher:
                MultiplePublisherTutorial()
            }
        }
    }
}

extension PublisherPage {

    enum Destination: String, CaseIterable {
        case custom
        case mapping
        case filtering
        case reducing
        case mathematic
        case matching
        case sequenceOperator
        case specificElement
        case multiplePublisher
    }
}


#Preview {
    PublisherPage()
}
