//
//  SequenceOperatorTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/17.
//

import SwiftUI
import Combine

struct SequenceOperatorTutorial: View {

    @State private var bags = Set<AnyCancellable>()
    var body: some View {
        List {
            drop
            dropFirst
            dropWhile
            append
            append2
            append3
            prepend
            prefix1
            prefix2
        }
        .navigationTitle("SequenceOperator")
    }
}

extension SequenceOperatorTutorial {

    
    // MARK: - func drop<P>(untilOutputFrom publisher: P) -> Publishers.DropUntilOutput<Self, P> where P : Publisher, Self.Failure == P.Failure
    /// Use drop(untilOutputFrom:) to ignore elements from the upstream publisher until another, second, publisher delivers its first element. This publisher requests a single value from the second publisher, and it ignores (drops) all elements from the upstream publisher until the second publisher produces a value. After the second publisher produces an element, drop(untilOutputFrom:) cancels its subscription to the second publisher, and allows events from the upstream publisher to pass through.
    /// 使用drop(untilOutputFrom:)来忽略来自上游发布者的元素，直到另一个发布者交付它的第一个元素。
    /// 在第二个发布者生成元素之后，drop(untilOutputFrom:)取消其对第二个发布者的订阅，
    /// 并允许来自上游发布者的事件通过。
    var drop: some View {
        Button("Drop") {
            let upStream = PassthroughSubject<Int, Never>()
            let second = PassthroughSubject<String, Never>()
            upStream.drop(untilOutputFrom: second)
                .sinkAutoPrint()
                .store(in: &bags)

            upStream.send(1)
            upStream.send(2)
            upStream.send(3)
            second.send("second 1")
            second.send("second 2")
            upStream.send(4)
            upStream.send(5)
            upStream.send(6)
        }
    }

    // MARK: - func dropFirst(_ count: Int = 1) -> Publishers.Drop<Self>
    /// Use dropFirst(_:) when you want to drop the first n elements from the upstream publisher, and republish the remaining elements.
    var dropFirst: some View {
        Button("DropFirst") {
            let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
            numbers.publisher
                .dropFirst(5)
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func drop(while predicate: @escaping (Self.Output) -> Bool) -> Publishers.DropWhile<Self>
    /// Use drop(while:) to omit elements from an upstream publisher until the element received meets a condition you specify.
    /// 使用drop(while:)从上游发布者中省略元素，如果满足条件，则drop。
    var dropWhile: some View {
        Button("DropWhile") {
            let numbers = [-62, -1, 0, 10, 0, 22, 41, -1, 5]
            numbers.publisher
                .drop { $0 <= 0 }
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func append(_ elements: Self.Output...) -> Publishers.Concatenate<Self, Publishers.Sequence<[Self.Output], Self.Failure>>
    var append: some View {
        Button("Append") {
            let dataElements = (0...10)
            dataElements.publisher
                .append(11, 0, 1)
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func append<S>(_ elements: S) -> Publishers.Concatenate<Self, Publishers.Sequence<S, Self.Failure>> where S : Sequence, Self.Output == S.Element
    var append2: some View {
        Button("Append2") {
            let groundTransport = ["car", "bus", "truck", "subway", "bicycle"]
            let airTransport = ["parasail", "jet", "helicopter", "rocket"]
            groundTransport.publisher
                .append(airTransport)
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func append<P>(_ publisher: P) -> Publishers.Concatenate<Self, P> where P : Publisher, Self.Failure == P.Failure, Self.Output == P.Output
    var append3: some View {
        Button("Append3") {
            let numbers = (0...10)
            let otherNumbers = (25...35)
            numbers.publisher
                .append(otherNumbers.publisher)
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func prepend(_ elements: Self.Output...) -> Publishers.Concatenate<Publishers.Sequence<[Self.Output], Self.Failure>, Self>
    /// Use prepend(_:) when you need to prepend specific elements before the output of a publisher.
    /// 很好理解，可以参考append，也有三个方法
    var prepend: some View {
        Button("Prepend") {
            let dataElements = (0...10)
            dataElements.publisher
                .prepend(0, 1, 4)
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func prefix(_ maxLength: Int) -> Publishers.Output<Self>
    /// Use prefix(_:) to limit the number of elements republished to the downstream subscriber.
    /// 很好理解，同样可以参考append，也有三个方法
    var prefix1: some View {
        Button("Prefix") {
            let numbers = (0...10)
            numbers.publisher
                .prefix(2)
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func prefix<P>(untilOutputFrom publisher: P) -> Publishers.PrefixUntilOutput<Self, P> where P : Publisher
    /// A publisher that republishes elements until the second publisher publishes an element.
    var prefix2: some View {
        Button("Prefix2") {
            let subject1 = PassthroughSubject<Int, Never>()
            let subject2 = PassthroughSubject<String, Never>()
            subject1.prefix(untilOutputFrom: subject2)
                .sinkAutoPrint()
                .store(in: &bags)

            subject1.send(1)
            subject1.send(2)
            subject1.send(3)
            subject2.send("One")
            subject2.send("Two")
            subject1.send(4)
            subject2.send("There")
            subject1.send(5)

        }
    }
}

#Preview {
    SequenceOperatorTutorial()
}
