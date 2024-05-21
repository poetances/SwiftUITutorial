//
//  MatchingTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/17.
//

import SwiftUI
import Combine

struct MatchingTutorial: View {

    @State private var bags = Set<AnyCancellable>()

    var body: some View {
        List {
            contains
            contains2
            allSatisfy
        }
        .navigationTitle("Matching")
    }
}

extension MatchingTutorial {

    // MARK: - func contains(_ output: Self.Output) -> Publishers.Contains<Self>
    ///  Use contains(_:) to find the first element in an upstream that’s equal to the supplied argument. The contains publisher consumes all received elements until the upstream publisher produces a matching element. Upon finding the first match, it emits true and finishes normally. If the upstream finishes normally without producing a matching element, this publisher emits false and finishes.
    var contains: some View {
        Button("Contains") {
            let numbers = [-1, 5, 10, 5]
            numbers.publisher
                .contains(5)
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func contains(where predicate: @escaping (Self.Output) -> Bool) -> Publishers.ContainsWhere<Self>
    /// Use contains(where:) to find the first element in an upstream that satisfies the closure you provide. This operator consumes elements produced from the upstream publisher until the upstream publisher produces a matching element.
    var contains2: some View {
        Button("Contains2") {
            let numbers = [-1, 5, 10, 5]
            numbers.publisher
                .contains { $0 > 4 }
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func allSatisfy(_ predicate: @escaping (Self.Output) -> Bool) -> Publishers.AllSatisfy<Self>
    /// Use the allSatisfy(_:) operator to determine if all elements in a stream satisfy a criteria you provide. When this publisher receives an element, it runs the predicate against the element. If the predicate returns false, the publisher produces a false value and finishes. If the upstream publisher finishes normally, this publisher produces a true value and finishes.
    /// 所有的元素都满足闭包中的条件，返回true，反之则为false
    var allSatisfy: some View {
        Button("AllSatisfy") {
            let numbers = [-1, 5, 10,  5]
            numbers.publisher
                .allSatisfy { $0 > -2 }
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }
}

#Preview {
    MatchingTutorial()
}
