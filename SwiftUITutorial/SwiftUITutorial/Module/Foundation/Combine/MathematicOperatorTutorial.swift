//
//  MathematicOperatorTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/17.
//

import SwiftUI
import Combine
struct MathematicOperatorTutorial: View {

    @State private var bags = Set<AnyCancellable>()

    // MARK: - system
    var body: some View {
        List {
            count
            max
            max2
            min
        }
        .navigationTitle("Mathematic")
    }
}

extension MathematicOperatorTutorial {

    // MARK: - func count() -> Publishers.Count<Self>
    /// Use count() to determine the number of elements received from the upstream publisher before it completes:
    var count: some View {
        Button("Count") {
            let numbers = (0...5)
            numbers.publisher
                .count()
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func max() -> Publishers.Comparison<Self>
    /// Use max() to determine the maximum value in the stream of elements from an upstream publisher.
    /*
     extension Publishers.Sequence where Failure == Never, Elements.Element : Comparable {

         public func min() -> Optional<Publishers.Sequence<Elements, Failure>.Output>.Publisher

         public func max() -> Optional<Publishers.Sequence<Elements, Failure>.Output>.Publisher
     }
     */
    var max: some View {
        Button("Max") {
            let numbers = [3, 5, 10, 2]
            numbers.publisher
                .max()
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func max(by areInIncreasingOrder: @escaping (Self.Output, Self.Output) -> Bool) -> Publishers.Comparison<Self>
    /// Use max(by:) to determine the maximum value of elements received from the upstream publisher based on an ordering closure you specify.
    enum Rank: Int {
        case ace = 1, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
    }
    var max2: some View {
        Button("Max2") {
            let cards: [Rank] = [.five, .queen, .ace, .eight, .jack]
            cards.publisher
                .max { $0.rawValue > $1.rawValue }
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func min() -> Publishers.Comparison<Self>
    /// Use min(by:) to find the minimum value in a stream of elements from an upstream publisher.
    var min: some View {
        Button("Min") {
            let numbers = [3, 5, 10, 2]
            numbers.publisher
                .min()
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }
}


#Preview {
    MathematicOperatorTutorial()
}
