//
//  FilteringTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/9.
//

import SwiftUI
import Combine

struct FilteringTutorial: View {

    @State private var bags = Set<AnyCancellable>()
    // MARK: - system
    var body: some View {
        List {
            filter
            tryFilter
            compactMap
            tryCompactMap
            removeDuplicates
            removeDuplicates2
            tryRemoveDuplicates
            replaceEmpty
            replaceError
        }
        .navigationTitle("Filtering")
    }
}

extension FilteringTutorial {

    // MARK: - func filter(_ isIncluded: @escaping (Self.Output) -> Bool) -> Publishers.Filter<Self>
    /// Republishes all elements that match a provided closure.
    var filter: some View {
        Button("Filter") {
            let numbers = [1, 2, 3, 4, 5]
            numbers.publisher
                .filter { $0 % 2 == 0}
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func tryFilter(_ isIncluded: @escaping (Self.Output) throws -> Bool) -> Publishers.TryFilter<Self>
    /// func tryFilter(_ isIncluded: @escaping (Self.Output) throws -> Bool) -> Publishers.TryFilter<Self>
    struct ZeroError: Error {}
    var tryFilter: some View {
        Button("TryFilter") {
            let numbers = [1, 2, 3, 4, 0, 5, 6]
            numbers.publisher
                .tryFilter {
                    if $0 == 0 {
                        throw ZeroError()
                    } else {
                        return $0 % 2 == 0
                    }
                }
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func compactMap<T>(_ transform: @escaping (Self.Output) -> T?) -> Publishers.CompactMap<Self, T>
    /// Calls a closure with each received element and publishes any returned optional that has a value.
    ///
    /// Combine’s compactMap(_:) operator performs a function similar to that of compactMap(_:) in the Swift standard library: the compactMap(_:) operator in Combine removes nil elements in a publisher’s stream and republishes non-nil elements to the downstream subscriber.
    ///  compactMap会移除闭包中为nil的元素
    var compactMap: some View {
        Button("CompactMap") {
            let numbers = (0...5) // 元祖(ClosedRange<Int>)
            let numbers1 = 0...5
            print(type(of: numbers), type(of: numbers1))
            let romanNumeralDict = [1: "I", 5: "V", 2: "II", 3: "III"]
            numbers.publisher
                .compactMap { romanNumeralDict[$0] }
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func tryCompactMap<T>(_ transform: @escaping (Self.Output) throws -> T?) -> Publishers.TryCompactMap<Self, T>
    struct ParseError: Error {}
    func romanNumeral(from: Int) throws -> String? {
        let romanNumeralDict: [Int : String] =
            [1: "I", 2: "II", 3: "III", 4: "IV", 5: "V"]
        guard from != 0 else { throw ParseError() }
        return romanNumeralDict[from]
    }
    var tryCompactMap: some View {
        Button("TryCompactMap") {
            let numbers = [6, 5, 4, 3, 2, 1, 0]
            numbers.publisher
                .tryCompactMap { try romanNumeral(from: $0) }
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func removeDuplicates() -> Publishers.RemoveDuplicates<Self>
    /// Use removeDuplicates() to remove repeating elements from an upstream publisher. This operator has a two-element memory: the operator uses the current and previously published elements as the basis for its comparison.
    var removeDuplicates: some View {
        Button("RemoveDuplicates") {
            let numbers = [0, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 0]
            numbers.publisher
                .removeDuplicates()
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func removeDuplicates(by predicate: @escaping (Self.Output, Self.Output) -> Bool) -> Publishers.RemoveDuplicates<Self>
    /// Use removeDuplicates(by:) to remove repeating elements from an upstream publisher based upon the evaluation of the current and previously published elements using a closure you provide.
    ///
    /// Use the removeDuplicates(by:) operator when comparing types that don’t themselves implement Equatable, or if you need to compare values differently than the type’s Equatable implementation.
    /// 
    ///  ```
    /// extension Publishers.Sequence where Elements.Element : Equatable {
    ///     public func removeDuplicates() -> Publishers.Sequence<[Publishers.Sequence<Elements, Failure>.Output], Failure>
    ///
    ///     public func contains(_ output: Elements.Element) -> Result<Bool, Failure>.Publisher
    ///  }
    ///  ```
    struct Point {
        let x: Int
        let y: Int
    }
    var removeDuplicates2: some View {
        Button("RemoveDuplicates2") {
            let points = [
                Point(x: 0, y: 0), Point(x: 0, y: 1),
                Point(x: 1, y: 1), Point(x: 2, y: 1)
            ]
            points.publisher
                .removeDuplicates { prev, current in
                    // 如果返回true，则认为元素相等
                    prev.x == current.x
                }
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func tryRemoveDuplicates(by predicate: @escaping (Self.Output, Self.Output) throws -> Bool) -> Publishers.TryRemoveDuplicates<Self>

    /// A closure to evaluate whether two elements are equivalent, for purposes of filtering. Return true from this closure to indicate that the second element is a duplicate of the first. If this closure throws an error, the publisher terminates with the thrown error.
    struct BadValuesError: Error {}
    var tryRemoveDuplicates: some View {
        Button("TryRemoveDuplicates") {
            let numbers = [0, 0, 0, 0, 1, 4, 4, 4, 4, 2, 2, 3, 3, 3]
            numbers.publisher
                .tryRemoveDuplicates { prev, current in
                    if prev == 4, current == 4 {
                        throw BadValuesError()
                    }
                    return prev == current
                }
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func replaceEmpty(with output: Self.Output) -> Publishers.ReplaceEmpty<Self>
    /// Use replaceEmpty(with:) to provide a replacement element if the upstream publisher finishes without producing any elements.
    var replaceEmpty: some View {
        Button("ReplaceEmpty") {
            let numbers: [Double] = []
            numbers.publisher
                .replaceEmpty(with: Double.nan)
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func replaceError(with output: Self.Output) -> Publishers.ReplaceError<Self>
    /// If the upstream publisher fails with an error, this publisher emits the provided element, then finishes normally.
    struct MyError: Error {}
    var replaceError: some View {
        Button("ReplaceError") {
            let fail = Fail<String, MyError>(error: MyError())
            fail.replaceError(with: "(replacement element)")
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }
}

#Preview {
    FilteringTutorial()
}
