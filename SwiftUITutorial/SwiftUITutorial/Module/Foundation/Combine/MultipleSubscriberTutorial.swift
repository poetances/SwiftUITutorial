//
//  MultipleSubscriberTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/24.
//

import SwiftUI
import Combine

struct MultipleSubscriberTutorial: View {

    @State private var bags = Set<AnyCancellable>()
    var body: some View {
        List {
            multicast
            multicast2
            share
        }
        .navigationTitle("MultipleSubscriber")
    }
}

extension MultipleSubscriberTutorial {

    // MARK: - func multicast<S>(_ createSubject: @escaping () -> S) -> Publishers.Multicast<Self, S> where S : Subject, Self.Failure == S.Failure, Self.Output == S.Output
    /// Use a multicast publisher when you have multiple downstream subscribers, but you want upstream publishers to only process one receive(_:) call per event. This is useful when upstream publishers are doing expensive work you don’t want to duplicate, like performing network requests.
    /// In contrast with multicast(subject:), this method produces a publisher that creates a separate Subject for each subscriber.
    /*
     Publisher 的订阅次数
     任意次数：在 Combine 框架中，一个 Publisher 可以被订阅多次。每一个新的订阅者都会接收到该 Publisher 发送的事件。这适用于大多数 Publisher 类型，包括 PassthroughSubject。

     每个订阅者独立处理：对于每一个新的订阅者，Publisher 会为其单独处理发送的事件。这意味着，每个订阅者都会接收到从其订阅时开始的所有事件。

     为什么需要 multicast 操作符
     尽管 PassthroughSubject 和其他 Publisher 可以被多次订阅，但 multicast 操作符在某些特定场景下具有独特的优势：

     减少重复工作：

     PassthroughSubject 示例：每个订阅者都会独立接收到所有发送的事件。但如果你的 Publisher 是一个昂贵的操作（例如网络请求、数据库查询等），每个订阅者独立处理这些操作可能会导致不必要的重复工作。
     multicast 解决方案：multicast 可以把一个 Publisher 的输出通过一个共享的 Subject 多播给多个订阅者，从而减少重复工作。例如，一个网络请求只会被执行一次，而结果会被广播给所有订阅者。
     避免副作用：

     副作用：某些 Publisher 在每次订阅时可能会产生副作用（例如启动一个新的网络请求、改变状态等）。
     multicast 解决方案：通过使用 multicast，可以确保这些副作用只发生一次，而不是每个订阅者都触发一次。
     控制订阅时机：

     multicast 允许你手动控制何时连接到上游 Publisher，并开始发送事件。你可以在所有订阅者都订阅之后再连接，从而确保所有订阅者都能接收到事件。
     */
    var multicast: some View {
        Button("Multicast") {
            let publisher = ["First", "Second", "Third"]
                .publisher
                .map { ($0, Int.random(in: 0...100)) }
                .print("Random")
                .multicast { PassthroughSubject<(String, Int), Never>() }

            publisher.sink { cp in
                print("completion1", cp)
            } receiveValue: { value in
                print("receive value1", value)
            }.store(in: &bags)

            publisher.sink { cp in
                print("completion2", cp)
            } receiveValue: { value in
                print("receive value2", value)
            }.store(in: &bags)

            publisher.connect().store(in: &bags)
        }
    }

    // MARK: - func multicast<S>(subject: S) -> Publishers.Multicast<Self, S> where S : Subject, Self.Failure == S.Failure, Self.Output == S.Output
    /// 方法接受一个现有的 Subject 实例作为参数。它将使用这个 Subject 来进行多播。
    /// 而上面的方法是创建一个Subject，使用创建的Subject进行多播
    var multicast2: some View {
        Button("Multicast2") {
            let subject = PassthroughSubject<(String, Int), Never>()
            let publisher = ["First", "Second", "Third"]
                .publisher
                .map { ($0, Int.random(in: 0...100)) }
                .print("Random")
                .multicast(subject: subject)

            publisher.sink { cp in
                print("completion1", cp)
            } receiveValue: { value in
                print("receive value1", value)
            }
            .store(in: &bags)

            publisher.sink { cp in
                print("completion2", cp)
            } receiveValue: { value in
                print("receive value2", value)
            }
            .store(in: &bags)

            publisher.connect().store(in: &bags)
        }
    }

    // MARK: - func share() -> Publishers.Share<Self>
    /// Publishers.Share is effectively a combination of the Publishers.Multicast and PassthroughSubject publishers, with an implicit autoconnect().
    var share: some View {
        Button("Share") {
            let publisher = (1...3).publisher
                .delay(for: .seconds(1), scheduler: DispatchQueue.main)
                .share()

            publisher.sink { cp in
                print("completion1", cp)
            } receiveValue: { value in
                print("receive value1", value)
            }
            .store(in: &bags)

            publisher.sink { cp in
                print("completion2", cp)
            } receiveValue: { value in
                print("receive value2", value)
            }
            .store(in: &bags)

        }
    }
}

#Preview {
    MultipleSubscriberTutorial()
}
