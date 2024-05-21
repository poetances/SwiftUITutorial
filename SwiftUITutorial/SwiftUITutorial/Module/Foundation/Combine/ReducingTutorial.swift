//
//  ReducingTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/16.
//

import SwiftUI
import Combine

struct ReducingTutorial: View {
    
    @State private var bags = Set<AnyCancellable>()
    // MARK: - system
    var body: some View {
        List {
            collect
            collect2
            collect3
            ignoreOutPut
            reduce
            tryReduce
        }
        .navigationTitle("ReducingElement")
    }
}

extension ReducingTutorial {

    // MARK: - func collect() -> Publishers.Collect<Self>
    /// Use collect() to gather elements into an array that the operator emits after the upstream publisher finishes.
    var collect: some View {
        Button("Collect") {
            let numbers = (0...10)
            numbers.publisher
                .collect()
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func collect(_ count: Int) -> Publishers.CollectByCount<Self>
    /// Use collect(_:) to emit arrays of at most count elements from an upstream publisher. If the upstream publisher finishes before collecting the specified number of elements, the publisher sends an array of only the items it received. This may be fewer than count elements.
    /// 注意，emit arrays of at most count elements from an upstream publisher，也就是从上面的发布的元素会以count值，类进行拆分
    var collect2: some View {
        Button("Collect2") {
            let numbers = (0...10)
            numbers.publisher
                .collect(4)
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func collect<S>(_ strategy: Publishers.TimeGroupingStrategy<S>, options: S.SchedulerOptions? = nil) -> Publishers.CollectByTime<Self, S> where S : Scheduler
    /// Use collect(_:options:) to emit arrays of elements on a schedule specified by a Scheduler and Stride that you provide. At the end of each scheduled interval, the publisher sends an array that contains the items it collected. If the upstream publisher finishes before filling the buffer, the publisher sends an array that contains items it received. This may be fewer than the number of elements specified in the requested Stride.
    /// ```
    /// enum TimeGroupingStrategy<Context> where Context : Scheduler
    /// case byTime(Context, Context.SchedulerTimeType.Stride)
    /// case byTimeOrCount(Context, Context.SchedulerTimeType.Stride, Int)
    var collect3: some View {
        Button("Collect3") {
            Timer.publish(every: 1.0, on: .main, in: .common)
                .autoconnect()
                .collect(.byTime(RunLoop.main, .seconds(5)))
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func ignoreOutput() -> Publishers.IgnoreOutput<Self>
    /// Use the ignoreOutput() operator to determine if a publisher is able to complete successfully or would fail.
    struct NoZeroValuesAllowedError: Error {}
    var ignoreOutPut: some View {
        Button("IgnoreOutPut") {
            let numbers = [1, 2, 3, 4, 5, 0, 6, 7, 8, 9]
            numbers.publisher
                .tryFilter { anInt in
                    guard anInt != 0 else { throw NoZeroValuesAllowedError() }
                    return anInt < 20
                }
                .ignoreOutput()
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func reduce<T>(_ initialResult: T, _ nextPartialResult: @escaping (T, Self.Output) -> T) -> Publishers.Reduce<Self, T>
    ///  Use reduce(_:_:) to collect a stream of elements and produce an accumulated value based on a closure you provide.
    var reduce: some View {
        Button("Reduce") {
            let numbers = (0...10)
            numbers.publisher
                .reduce(0) { $0 + $1 }
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func tryReduce<T>(_ initialResult: T, _ nextPartialResult: @escaping (T, Self.Output) throws -> T) -> Publishers.TryReduce<Self, T>
    /// Use tryReduce(_:_:) to collect a stream of elements and produce an accumulated value based on an error-throwing closure you provide. If the closure throws an error, the publisher fails and passes the error to its subscriber.
    /// 注意最后一句话，如果失败，那么直接就会发布失败。
    struct DivisionByZeroError: Error {}
    func myDivide(_ dividend: Double, _ divisor: Double) throws -> Double {
        guard divisor != 0 else { throw DivisionByZeroError() }
        return dividend / divisor
    }
    var tryReduce: some View {
        Button("TryReduce") {
            let numbers: [Double] = [5, 4, 3, 0, 2, 1]
            numbers.publisher
                .tryReduce(0) { account, next in
                    try myDivide(account, next)
                }
                .sinkAutoPrint()
                .store(in: &bags)

        }
    }
}

#Preview {
    ReducingTutorial()
}
