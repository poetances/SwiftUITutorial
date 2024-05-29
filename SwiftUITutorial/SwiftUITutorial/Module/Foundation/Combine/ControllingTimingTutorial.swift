//
//  ControllingTimingTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/22.
//

import SwiftUI
import Combine

struct ControllingTimingTutorial: View {

    @State private var bags = Set<AnyCancellable>()
    var body: some View {
        List {
            measureInterval
            debounce
            delay
            throttle
            timeout
        }
        .navigationTitle("ControllingTiming")
    }
}

extension ControllingTimingTutorial {

    // MARK: - func measureInterval<S>(using scheduler: S, options: S.SchedulerOptions? = nil) -> Publishers.MeasureInterval<Self, S> where S : Scheduler
    /// Use measureInterval(using:options:) to measure the time between events delivered from an upstream publisher.
    /// 在 Combine 框架中，measureInterval(using:options:) 是一个操作符，用于测量两个事件之间的时间间隔。它可以应用于任何发布者（Publisher），并且在两个连续的元素到达时，会计算它们之间的时间间隔，并将其作为新的元素发布出去。

    ///这个操作符返回的是一个新的发布者，它的元素类型是时间间隔。你可以使用它来监视事件之间的时间间隔，以便根据需要进行后续操作。
    var measureInterval: some View {
        Button("MeasureInterval") {
            Timer.publish(every: 1.0, on: .main, in: .common)
                .autoconnect()
                .measureInterval(using: RunLoop.main)
                .sink { cp in
                    print("completion", cp)
                } receiveValue: { value in
                    print(value)
                }
                .store(in: &bags)
        }
    }

    // MARK: - func debounce<S>(for dueTime: S.SchedulerTimeType.Stride, scheduler: S, options: S.SchedulerOptions? = nil) -> Publishers.Debounce<Self, S> where S : Scheduler
    /// Publishes elements only after a specified time interval elapses between events.
    ///
    /// Use the debounce(for:scheduler:options:) operator to control the number of values and time between delivery of values from the upstream publisher. This operator is useful to process bursty or high-volume event streams where you need to reduce the number of values delivered to the downstream to a rate you specify.
    
    /// debounce(for:scheduler:options:) 是一个操作符，用于减少事件的频率。它可以应用于任何发布者（Publisher），并且会等待一定的时间间隔，在该时间间隔内没有新的事件到达时，才会将最新的事件发送出去。
    var debounce: some View {
        Button("Debounce") {
            let searchPublisher = PassthroughSubject<String, Never>()

            searchPublisher.debounce(for: 0.5, scheduler: DispatchQueue.main)
                .sinkAutoPrint()
                .store(in: &bags)

            // 模拟用户输入搜索关键词
            searchPublisher.send("C")
            searchPublisher.send("Co")
            searchPublisher.send("Com")
            searchPublisher.send("Comb")
            searchPublisher.send("Combi")
            searchPublisher.send("Combin")
            searchPublisher.send("Combine")
        }
    }

    // MARK: - func delay<S>(for interval: S.SchedulerTimeType.Stride, tolerance: S.SchedulerTimeType.Stride? = nil, scheduler: S, options: S.SchedulerOptions? = nil) -> Publishers.Delay<Self, S> where S : Scheduler
    /// Delays delivery of all output to the downstream receiver by a specified amount of time on a particular scheduler.
    ///
    /// Use delay(for:tolerance:scheduler:options:) when you need to delay the delivery of elements to a downstream by a specified amount of time.
    /// 这个操作符会等待指定的时间间隔，然后再将接收到的事件发送出去。你可以使用这个操作符来实现一些延迟执行的逻辑，比如延迟处理用户输入、延迟执行某些操作等。
    var delay: some View {
        Button("Delay") {
            let df = DateFormatter()
            df.dateStyle = .none
            df.timeStyle = .long
            Timer.publish(every: 1.0, on: .main, in: .default)
                .autoconnect()
                .handleEvents { _ in

                } receiveOutput: { date in
                    print ("Sending Timestamp \'\(df.string(from: date))\' to delay()")
                }
                .delay(for: .seconds(3), scheduler: RunLoop.main)
                .sink { cp in
                    print("completion", cp)
                } receiveValue: { value in
                    let now = Date()
                    print ("At \(df.string(from: now)) received  Timestamp \'\(df.string(from: value))\' sent: \(String(format: "%.2f", now.timeIntervalSince(value))) secs ago", terminator: "\n")
                }
                .store(in: &bags)

            // Prints:
            //    Sending Timestamp '5:02:33 PM PDT' to delay()
            //    Sending Timestamp '5:02:34 PM PDT' to delay()
            //    Sending Timestamp '5:02:35 PM PDT' to delay()
            //    Sending Timestamp '5:02:36 PM PDT' to delay()
            //    At 5:02:36 PM PDT received  Timestamp '5:02:33 PM PDT' sent: 3.00 secs ago
            //    Sending Timestamp '5:02:37 PM PDT' to delay()
            //    At 5:02:37 PM PDT received  Timestamp '5:02:34 PM PDT' sent: 3.00 secs ago
            //    Sending Timestamp '5:02:38 PM PDT' to delay()
            //    At 5:02:38 PM PDT received  Timestamp '5:02:35 PM PDT' sent: 3.00 secs ago

        }
    }

    // MARK: - func throttle<S>(for interval: S.SchedulerTimeType.Stride, scheduler: S, latest: Bool) -> Publishers.Throttle<Self, S> where S : Scheduler
    /// Use throttle(for:scheduler:latest:) to selectively republish elements from an upstream publisher during an interval you specify. Other elements received from the upstream in the throttling interval aren’t republished.
    ///throttle操作符会在指定的时间间隔内只发送最新的事件，而忽略在此期间内产生的其他事件。它会等待指定的时间间隔，并在此期间内收到新事件时，忽略这些新事件，只发送最后收到的那个事件。这个操作符通常用于处理频繁事件的场景，比如用户输入、传感器数据等，以避免过于频繁地处理这些事件。
    var throttle: some View {
        Button("Throttle") {
           Timer.publish(every: 3.0, on: .main, in: .default)
                .autoconnect()
                .print("\(Date().description)")
                .throttle(for: 10.0, scheduler: RunLoop.main, latest: true)
                .sink(
                    receiveCompletion: { print ("Completion: \($0).") },
                    receiveValue: { print("Received Timestamp \($0).") }
                 )
                .store(in: &bags)
        }
    }

    // MARK: - func timeout<S>(_ interval: S.SchedulerTimeType.Stride, scheduler: S, options: S.SchedulerOptions? = nil, customError: (() -> Self.Failure)? = nil) -> Publishers.Timeout<Self, S> where S : Scheduler
    /// Terminates publishing if the upstream publisher exceeds the specified time interval without producing an element.
    var timeout: some View {
        Button("Timeout") {
            let subject = PassthroughSubject<Int, Never>()
            subject
                .timeout(5, scheduler: DispatchQueue.main)
                .sink { cp in
                print("completion", cp, Date())
            } receiveValue: { value in
                print("receive value", value, Date())
            }
            .store(in: &bags)

            DispatchQueue.main.asyncAfter(
                deadline: .now() + 2,
                execute: { subject.send(1) }
            )
        }
    }
}

#Preview {
    ControllingTimingTutorial()
}
