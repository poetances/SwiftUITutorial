//
//  MappingTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/8.
//

import SwiftUI
import Combine

struct MappingTutorial: View {

    @State private var bags = Set<AnyCancellable>()

    // MARK: - system
    var body: some View {
        List {
            map
            tryMap
            mapError
            replaceNil
            scan
            tryScan
            setFailureType
        }
        .navigationTitle("Mapping")
    }
}

extension MappingTutorial {

    // MARK: - func map<T>(_ transform: @escaping (Self.Output) -> T) -> Publishers.Map<Self, T>
    var map: some View {
        Button("Map") {
            let numbers = [5, 4, 3, 2, 1, 0]
            let romanNumeralDict = [1:"I", 2:"II", 3:"III", 4:"IV", 5:"V"]
            numbers.publisher
                .map { romanNumeralDict[$0] ?? "unkown" }
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func tryMap<T>(_ transform: @escaping (Self.Output) throws -> T) -> Publishers.TryMap<Self, T>
    /// A  closure that takes one element as its parameter and returns a new element. If the closure throws an error, the publisher fails with the thrown error.
    /// 即：如果当tryMap遇到error，则会抛出error，并停止输出
    var tryMap: some View {
        Button("TryMap") {
            let numbers = [5, 4, 0, 3, 2, 1]
            numbers.publisher
                .tryMap {  element in try romanNumeral(from: element) }
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    struct ParseError: Error {}
    func romanNumeral(from:Int) throws -> String {
        let romanNumeralDict: [Int : String] =
            [1:"I", 2:"II", 3:"III", 4:"IV", 5:"V"]
        guard let numeral = romanNumeralDict[from] else {
            throw ParseError()
        }
        return numeral
    }

    // MARK: - func mapError<E>(_ transform: @escaping (Self.Failure) -> E) -> Publishers.MapError<Self, E> where E : Error
    /// A closure that takes the upstream failure as a parameter and returns a new error for the publisher to terminate with.
    /// 将一个错误进行转换
    var mapError: some View {
        Button("MapError") {
            let divisors: [Double] = [5, 0, 4, 3, 2, 1]
            divisors.publisher
                .tryMap { try myDivide(1, $0) }
                .mapError { MyGenericError(wrappedError: $0) }
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }
    struct DivisionByZeroError: Error {}
    struct MyGenericError: Error { var wrappedError: Error }
    func myDivide(_ dividend: Double, _ divisor: Double) throws -> Double {
        guard divisor != 0 else { throw DivisionByZeroError() }
        return dividend / divisor
    }


    // MARK: - func replaceNil<T>(with output: T) -> Publishers.Map<Self, T> where Self.Output == T?
    /// The element to use when replacing nil.
    var replaceNil: some View {
        Button("MapNil") {
            let numbers: [Double?] = [1.0, 2.0, nil, 3.0]
            numbers.publisher
                .replaceNil(with: 0.0)
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func scan<T>(_ initialResult: T, _ nextPartialResult: @escaping (T, Self.Output) -> T) -> Publishers.Scan<Self, T>
    /// A publisher that transforms elements by applying a closure that receives its previous return value and the next element from the upstream publisher.
    var scan: some View {
        Button("Scan") {
            let range = 0...5
            range.publisher
                .scan(0) { $0 + $1 }
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func tryScan<T>(_ initialResult: T, _ nextPartialResult: @escaping (T, Self.Output) throws -> T) -> Publishers.TryScan<Self, T>
    ///
    func myThrowingFunction(_ lastValue: Int, _ currentValue: Int) throws -> Int {
        guard currentValue != 0 else { throw DivisionByZeroError() }
        return (lastValue + currentValue) / currentValue
    }
    var tryScan: some View {
        Button("TryScan") {
            let numbers = [1,2,3,4,5,0,6,7,8,9]
            numbers.publisher
                .tryScan(10) { try myThrowingFunction($0, $1) }
                .sinkAutoPrint()
                .store(in: &bags)

        }
    }

    // MARK: - func setFailureType<E>(to failureType: E.Type) -> Publishers.SetFailureType<Self, E> where E : Error
    /// Use setFailureType(to:) when you need set the error type of a publisher that cannot fail.
    ///
    /// Conversely, if the upstream can fail, you would use mapError(_:) to provide instructions on converting the error types to needed by the downstream publisher’s inputs.
    ///
    /// The following example has two publishers with mismatched error types: pub1’s error type is Never, and pub2’s error type is Error. Because of the mismatch, the combineLatest(_:) operator requires that pub1 use setFailureType(to:) to make it appear that pub1 can produce the Error type, like pub2 can.
    var setFailureType: some View {
        Button("SetFailureType") {
            let pub1 = [1, 2, 3, 4, 5].publisher
            let pub2 = CurrentValueSubject<Int, Error>(0)
            pub1.setFailureType(to: Error.self)
                .combineLatest(pub2)
                .sinkAutoPrint()
                .store(in: &bags)

            /*
             Instance method 'combineLatest' requires the types 'Never' and 'any Error' be equivalent
             pub1.combineLatest(pub2)
                 .sink { cp in
                     print("completion", cp)
                 } receiveValue: { value in
                     print("receive value", value)
                 }
                 .store(in: &bags)

             如上，如果没有setFailureType(to: Error.self)，那么会报错，因为
             func combineLatest<P, T>(
                 _ other: P,
                 _ transform: @escaping (Self.Output, P.Output) -> T
             ) -> Publishers.Map<Publishers.CombineLatest<Self, P>, T> where P : Publisher, Self.Failure == P.Failure
             前提是Failure是一样的
             */
        }
    }
}

#Preview {
    MappingTutorial()
}
