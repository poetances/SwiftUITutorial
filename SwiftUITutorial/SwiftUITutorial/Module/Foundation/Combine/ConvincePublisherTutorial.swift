//
//  ConvincePublisherTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/27.
//

import SwiftUI
import Combine

struct ConvincePublisherTutorial: View {

    @State private var bags = Set<AnyCancellable>()
    var body: some View {
        List {
            future
            just
            deferred
            empty
            fail
            record
        }
        .navigationTitle("ConvincePublisher")
    }
}

extension ConvincePublisherTutorial {

    // MARK: - final class Future<Output, Failure> where Failure : Error
    /// Use a future to perform some work and then asynchronously publish a single element. You initialize the future with a closure that takes a Future.Promise; the closure calls the promise with a Result that indicates either success or failure. In the success case, the future’s downstream subscriber receives the element prior to the publishing stream finishing normally. If the result is an error, publishing terminates with that error.
    ///
    /// The async-await syntax in Swift can also replace the use of a future entirely, for the case where you want to perform some operation after an asynchronous task completes.
    ///
    /// 也就是async-await其实是替代了Future的，我们实际开发中可能使用的会比较少
    var future: some View {
        Button("Future") {
            func generateAsyncRandomNumberFromFuture() -> Future<Int, Never> {
                Future { promise in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        let number = Int.random(in: 1...10)
                        promise(Result.success(number))
                    }
                }
            }

            let publisher = generateAsyncRandomNumberFromFuture()
            publisher.sinkAutoPrint().store(in: &bags)

            // 或者通过
            Task {
                let value = await publisher.value
                print("await value", value)
            }
        }
    }

    // MARK: - struct Just<Output>
    var just: some View {
        Button("Just") {
            let just = Just(12)
            just.sinkAutoPrint().store(in: &bags)
        }
    }

    // MARK: - struct Deferred<DeferredPublisher> where DeferredPublisher : Publisher
    /// 使用场景
    /// 延迟执行: 在需要延迟某些操作直到订阅时再执行的情况下使用。
    /// 保证重新创建: 确保每次订阅时都重新创建 Publisher，而不是重用之前的 Publisher。
    /// 动态生成 Publisher: 当需要根据订阅时的状态或外部条件动态生成 Publisher 时使用。
    var deferred: some View {
        Button("Deferred") {
            let deferred = Deferred {

                print("创建Publisher")
                return Just(Date())
            }
            deferred.sink { cp in
                print("completion", cp)
            } receiveValue: { value in
                print("receive value", value)
            }
            .store(in: &bags)

            deferred.sink { cp in
                print("completion1", cp)
            } receiveValue: { value in
                print("receive value1", value)
            }
            .store(in: &bags)
        }
    }

    // MARK: - struct Empty<Output, Failure> where Failure : Error
    /// 使用场景
    /// 占位符: 作为占位符使用，表示没有数据但需要一个 Publisher。
    /// 条件流控制: 在某些条件下不需要发送任何值，但需要完成流。
    /// 默认行为: 为某些操作提供默认行为，当没有其他数据需要发送时。
    var empty: some View {
        Button("Empty") {
            let empty = Empty<Int, Never>()
            empty.sinkAutoPrint().store(in: &bags)
        }
    }

    // MARK: - struct Fail<Output, Failure> where Failure : Error
    /// 模拟错误: 在测试和调试过程中，模拟错误情况。
    /// 条件控制: 在某些条件下立即失败。
    /// 默认错误行为: 为某些操作提供默认的错误行为。
    var fail: some View {
        Button("Fail") {
            let fail = Fail<Int, NSError>(error: NSError())
            fail.sinkAutoPrint().store(in: &bags)
        }
    }

    // MARK: - struct Record<Output, Failure> where Failure : Error
    /// 重放事件: 记录并重放一系列事件。
    /// 测试和调试: 在测试和调试过程中，模拟一系列预定义的事件。
    /// 自定义 Publisher 行为: 创建自定义的 Publisher 行为，预先定义其输出和完成事件。
    var record: some View {
        Button("Record") {
            let recordPublisher = Record<Int, Never>(output: [1, 2, 3, 4, 5], completion: .finished)

            recordPublisher.sink { cp in
                print("completion", cp)
            } receiveValue: { value in
                print("receive", value)
            }.store(in: &bags)
        }
    }
}

#Preview {
    ConvincePublisherTutorial()
}
