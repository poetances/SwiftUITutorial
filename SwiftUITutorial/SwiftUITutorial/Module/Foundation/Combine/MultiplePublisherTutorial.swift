//
//  MultiplePublisherTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/20.
//

import SwiftUI
import Combine

struct MultiplePublisherTutorial: View {

    @State private var bags = Set<AnyCancellable>()

    var body: some View {
        List {
            combineLatest
            combineLatest2
            merge
            zip
            flatMap
            switchToLatest
            switchToLatest2
        }
        .navigationTitle("MultiplePublisher")
    }
}

extension MultiplePublisherTutorial {

    // MARK: - func combineLatest<P, T>(_ other: P, _ transform: @escaping (Self.Output, P.Output) -> T) -> Publishers.Map<Publishers.CombineLatest<Self, P>, T> where P : Publisher, Self.Failure == P.Failure
    /// A publisher that receives and combines elements from this and another publisher.
    ///
    /// Use combineLatest<P,T>(_:) to combine the current and one additional publisher and transform them using a closure you specify to publish a new value to the downstream.
    var combineLatest: some View {
        Button("CombineLatest") {
            let pub1 = PassthroughSubject<Int, Never>()
            let pub2 = PassthroughSubject<String, Never>()
            pub1.combineLatest(pub2) { v1, v2 in
                "\(v2)-\(v1)"
            }
            .sinkAutoPrint()
            .store(in: &bags)

            pub1.send(1)
            pub1.send(3)
            pub2.send("A")
            pub1.send(5)
            pub1.send(7)
            pub2.send("B")
            pub1.send(9)
            pub2.send("C")
            pub1.send(11)
            pub2.send("D")

            /*
             receive value A-3
             receive value A-5
             receive value A-7
             receive value B-7
             receive value B-9
             receive value C-9
             receive value C-11
             receive value D-11
             */
        }
    }

    var combineLatest2: some View {
        Button("CombineLatest2") {
            let pub1 = PassthroughSubject<Int, Never>()
            let pub2 = PassthroughSubject<String, Never>()
            pub1.combineLatest(pub2)
                .sinkAutoPrint()
                .store(in: &bags)

            pub1.send(1)
            pub1.send(3)
            pub2.send("A")
            pub1.send(5)
            pub1.send(7)
            pub2.send("B")
            pub1.send(9)
            pub2.send("C")
            pub1.send(11)
            pub2.send("D")

            /*
             receive value (3, "A")
             receive value (5, "A")
             receive value (7, "A")
             receive value (7, "B")
             receive value (9, "B")
             receive value (9, "C")
             receive value (11, "C")
             receive value (11, "D")
             */
        }
    }

    // MARK: - func merge(with other: Self) -> Publishers.MergeMany<Self>
    /// Use merge(with:) when you want to receive a new element whenever any of the upstream publishers emits an element. To receive tuples of the most-recent value from all the upstream publishers whenever any of them emit a value, use combineLatest(_:). To combine elements from multiple upstream publishers, use zip(_:).
    /// 很好解释了combineLatest、merge和zip之间的区别
    var merge: some View {
        Button("Merge") {
            let pub1 = PassthroughSubject<Int, Never>()
            let pub2 = PassthroughSubject<Int, Never>()
            pub1.merge(with: pub2)
                .sinkAutoPrint()
                .store(in: &bags)

            pub1.send(1)
            pub2.send(2)
            pub1.send(3)
            pub1.send(5)
            pub2.send(4)
        }
    }

    // MARK: - func zip<P>(_ other: P) -> Publishers.Zip<Self, P> where P : Publisher, Self.Failure == P.Failure
    /// Use zip(_:) to combine the latest elements from two publishers and emit a tuple to the downstream. The returned publisher waits until both publishers have emitted an event, then delivers the oldest unconsumed event from each publisher together as a tuple to the subscriber.
    var zip: some View {
        Button("Zip") {
            let pub1 = PassthroughSubject<Int, Never>()
            let pub2 = PassthroughSubject<String, Never>()
            pub1.zip(pub2)
                .sinkAutoPrint()
                .store(in: &bags)

            pub1.send(1)
            pub1.send(2)
            pub2.send("One")
            pub1.send(3)
            pub2.send("Two")
        }
    }

    // MARK: - func flatMap<T, P>(maxPublishers: Subscribers.Demand = .unlimited, _ transform: @escaping (Self.Output) -> P -> Publishers.FlatMap<P, Self> where T == P.Output, P : Publisher, Self.Failure == P.Failure
    /// Combine‘s flatMap(maxPublishers:_:) operator performs a similar function to the flatMap(_:) operator in the Swift standard library, but turns the elements from one kind of publisher into a new publisher that is sent to subscribers. Use flatMap(maxPublishers:_:) when you want to create a new series of events for downstream subscribers based on the received value. The closure creates the new Publisher based on the received value. The new Publisher can emit more than one event, and successful completion of the new Publisher does not complete the overall stream. Failure of the new Publisher causes the overall stream to fail.
    /// 在Combine中，flatMap操作符非常强大且灵活，允许你将上游Publisher的输出转换为新的Publisher，并将它们的输出合并成一个单一的流。这在处理嵌套的异步操作（如网络请求或数据库查询）时特别有用。通过理解其签名和工作原理，你可以在实际开发中更有效地使用flatMap来处理复杂的异步数据流。
    var flatMap: some View {
        Button("FlatMap") {
            // 模拟API请求，每个请求返回一个包含延迟的Publisher
            struct API {
                static func fetchData(id: Int) -> AnyPublisher<String, Error> {
                    let delay = Double.random(in: 0.5...2.0)
                    return Future<String, Error> { promise in
                        DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                            if id == 3 {
                                promise(.failure(NSError(domain: "Test", code: 1, userInfo: nil)))
                            } else {
                                promise(.success("Data for id \(id)"))
                            }
                        }
                    }
                    .eraseToAnyPublisher()
                }
            }

            let idsPublisher = [1, 2, 3].publisher

            idsPublisher
                .flatMap { id in
                    API.fetchData(id: id)
                }
                .sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            print("Finished")
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                    },
                    receiveValue: { value in
                        print("Received value: \(value)")
                    }
                ).store(in: &bags)
        }
    }

    // MARK: - func switchToLatest() -> Publishers.SwitchToLatest<Self.Output, Self>
    /// This operator works with an upstream publisher of publishers, flattening the stream of elements to appear as if they were coming from a single stream of elements. It switches the inner publisher as new ones arrive but keeps the outer publisher constant for downstream subscribers.
    /// switchToLatest操作符用于在多个Publisher之间进行切换。当一个新的Publisher发出时，它会取消订阅之前的Publisher，并订阅新的Publisher。这样可以确保每次只处理最新的Publisher发出的事件，而忽略之前的Publisher。
    var switchToLatest: some View {
        Button("SwitchToLatest") {
            func search(query: String) -> AnyPublisher<String, Never> {
                print("search", query)
                return Just("Results for query \(query)")
                    .delay(for: .seconds(2), scheduler: DispatchQueue.main)
                    .eraseToAnyPublisher()
            }

            let userInput = PassthroughSubject<String, Never>()
            userInput.map { search(query: $0) }
                .switchToLatest()
                .sinkAutoPrint()
                .store(in: &bags)

            userInput.send("Swift")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                userInput.send("Combine")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                userInput.send("iOS")
            }
        }
    }

    /// 验证取消
    var switchToLatest2: some View {
        Button("SwitchToLatest2") {

            class URLSessionDelegate: NSObject, URLSessionDataDelegate {
                func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
                    if let error = error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled {
                        print("Request cancelled: \(task.originalRequest?.url?.absoluteString ?? ""))")
                    }
                }

                func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
                    print("Request didReceive: \(response.url?.absoluteString ?? ""))")
                    return .allow
                }

                func urlSession(_ session: URLSession, didCreateTask task: URLSessionTask) {

                }
            }

            let sessionDelegate = URLSessionDelegate()

            let session = URLSession(configuration: .default, delegate: sessionDelegate, delegateQueue: nil)

            let subject = PassthroughSubject<Int, Never>()

            subject
                .setFailureType(to: URLError.self)
                .map { index -> URLSession.DataTaskPublisher in
                    let url = URL(string: "https://reqres.in/api/users?page=\(index)")!
                    return session.dataTaskPublisher(for: url)
                }
                .switchToLatest()
                .sinkAutoPrint()
                .store(in: &bags)

            for index in 1...5 {
                DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(index) / 10) {
                    subject.send(index)
                }
            }
        }
    }
}

#Preview {
    MultiplePublisherTutorial()
}
