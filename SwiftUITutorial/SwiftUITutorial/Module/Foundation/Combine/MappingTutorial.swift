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
                .sink { value in
                    print(value)
                }
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
                .sink { completion in
                    print("completion::", completion)
                } receiveValue: { value in
                    print(value)
                }
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
                .sink { completion in
                    print("completion::", completion)
                } receiveValue: { value in
                    print(value)
                }
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
                .sink { value in
                    print(value ?? "null", terminator: " ")
                }
                .store(in: &bags)
        }
    }
}

#Preview {
    MappingTutorial()
}
