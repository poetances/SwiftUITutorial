//
//  SpecificElementTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/20.
//

import SwiftUI
import Combine

struct SpecificElementTutorial: View {

    @State private var bags = Set<AnyCancellable>()
    var body: some View {
        List {
            first
            first2
            last
            last2
            output
            output2
        }
        .navigationTitle("SpecificElement")
    }
}

extension SpecificElementTutorial {

    // MARK: - func first() -> Publishers.First<Self>
    var first: some View {
        Button("First") {
            let numbers = (-10...10)
            numbers.publisher
                .first()
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func first(where predicate: @escaping (Self.Output) -> Bool) -> Publishers.FirstWhere<Self>
    var first2: some View {
        Button("First2") {
            let numbers = (-10...10)
            numbers.publisher
                .first { $0 > 1 }
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func last() -> Publishers.Last<Self>
    var last: some View {
        Button("Last") {
            let numbers = (-10...10)
            numbers.publisher
                .last()
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func last(where predicate: @escaping (Self.Output) -> Bool) -> Publishers.LastWhere<Self>
    var last2: some View {
        Button("Last2") {
            let numbers = (-10...10)
            numbers.publisher
                .last { $0 < 0 }
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func output(at index: Int) -> Publishers.Output<Self>
    /// Use output(at:) when you need to republish a specific element specified by its position in the stream. If the publisher completes normally or with an error before publishing the specified element, then the publisher doesn’t produce any elements.
    var output: some View {
        Button("Output") {
            let numbers = (-10...10)
            numbers.publisher
                .output(at: 3)
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func output<R>(in range: R) -> Publishers.Output<Self> where R : RangeExpression, R.Bound == Int
    var output2: some View {
        Button("Output2") {
            let numbers = [1, 1, 2, 2, 2, 3, 4, 5, 6]
            numbers.publisher
                .output(in: 2..<4)
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }
}

#Preview {
    SpecificElementTutorial()
}
