//
//  CustomPubliserTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/10.
//

import SwiftUI
import Combine

/*

 当调用 .subscribe(_: Subscriber) 时，订阅者被连接到了发布者。
 发布者随后调用 receive(subscription: Subscription) 来确认该订阅。
 在订阅被确认后，订阅者请求值 N，此时调用 request(_: Demand)。
 发布者可能随后（当它有值时）发送 N 或者更少的值，通过调用 receive(_: Input)。 发布者不会发送超过需求量的值。
 订阅确认后的任何时间，订阅者都可能调用 .cancel() 来发送 cancellation
 发布者可以选择性地发送 completion：receive(completion:)。 完成可以是正常终止，也可以是通过 .failure 完成，可选地传递一个错误类型。 已取消的管道不会发送任何完成事件。
 */
struct CustomPubliserTutorial: View {


    @State private var bags = Set<AnyCancellable>()
    // MARK: - system
    var body: some View {
        List {
            Button("Publisher convince") {
                Publishers.CustomPubliser(value: 12)
                    .sink { cp in
                        print("completion", cp)
                    } receiveValue: { value in
                        print("recive::", value)
                    }
                    .store(in: &bags)
            }

            Button("Publisher") {
                let publisher = Publishers.CustomPubliser(value: "Poetances")
                let subscriber = Subscribers.Sink<String, Never> { cp in
                    print("completion", cp)
                } receiveValue: { value in
                    print("receive::", value)
                }
                publisher.subscribe(subscriber)
            }
        }
        .navigationTitle("Custom")
    }
}

extension Combine.Publishers {

    struct CustomPubliser<Output>: Publisher {

        typealias Failure = Never

        private let value: Output
        init(value: Output) {
            self.value = value
        }

        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Output == S.Input {
            let subscription = CustomSubscription(subscriber: subscriber, value: value)
            subscriber.receive(subscription: subscription)
        }
    }
}

extension Combine.Publishers.CustomPubliser {
    
    private final class CustomSubscription<S: Subscriber, Value>: Subscription where S.Input == Value {
        private var subscriber: S?
        private var value: Value

        init(subscriber: S? = nil, value: Value) {
            self.subscriber = subscriber
            self.value = value
        }

        func cancel() {
            subscriber = nil
        }

        func request(_ demand: Subscribers.Demand) {
           let _ = subscriber?.receive(value)
        }
    }
}

#Preview {
    CustomPubliserTutorial()
}
