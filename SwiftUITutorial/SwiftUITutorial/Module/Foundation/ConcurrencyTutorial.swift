//
//  ConcurrencyTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/1/31.
//

import SwiftUI

struct ConcurrencyTutorial: View {

    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {
            task
            task_cancellation
            taskGroup
            throwingTaskGroup
            discarding_task_group
            unsafeCurrentTask
        }
    }
}

extension ConcurrencyTutorial {

    var task: some View {
        Text("Task、Task.deteched、Task.isChanced、Task.checkCancelation、Task.yied、Task.sleep")
    }

    /*
     withTaskCancellationHandler
     */
    var task_cancellation: some View {
        Button("Listen cancellation") {
            Task {
                await taskCancellationHandler()
            }
        }
    }

    func taskCancellationHandler() async {
        await withTaskCancellationHandler {

        } onCancel: {
            print("on cancel")
        }
    }
}

// MARK: - TaskGroup
extension ConcurrencyTutorial {
    
    /*
     TaskGroup
     通过withTaskGroup(of:returning:body:) 来创建。

     Don’t use a task group from outside the task where you created it. In most cases, the Swift type system prevents a task group from escaping like that because adding a child task to a task group is a mutating operation, and mutation operations can’t be performed from a concurrent execution context like a child task.
     */
    var taskGroup: some View {
        Button("TaskGroup") {
            Task {
                await taskGroup()
            }
        }
    }

    func taskGroup() async {
       let result = await withTaskGroup(of: String.self) { group in
           group.addTask {
               print("1", Thread.current)
               try! await Task.sleep(nanoseconds: 3_000_000_000)
               return "1"
           }

           group.addTask {
               print("2", Thread.current)
               try! await Task.sleep(nanoseconds: 1_000_000_000)
               return "2"
           }

           var value = [String]()
           for await op in group {
               value.append(op)
           }
           return value
        }
        print(result)
    }
}

// MARK: - ThrowingTaskGroup
extension ConcurrencyTutorial {

    /*
     ThrowingTaskGroup
     通过withThrowingTaskGroup(of:returning:body:)来创建

     mutating func addTask(
         priority: TaskPriority? = nil,
         operation: @escaping () async throws -> ChildTaskResult
     )
     其和TaskGroup相比，最大的区别就是operation里面是async throws，即可以抛出异常

     addTaskUnlessCancelled(priority:operation:) -> Bool
     如果任务取消，则不会添加到任务中
     */
    var throwingTaskGroup: some View {
        Button("ThrowingTaskGroup") {
            Task {
                try? await throwingTaskGroup()
            }
        }
    }

    func throwingTaskGroup() async throws {
       let result = try await withThrowingTaskGroup(of: String.self) { group in
            group.addTask(priority: .background) {
                try! await Task.sleep(nanoseconds: 3_000_000_000)
                throw NSError()
            }

           group.addTask {
               try! await Task.sleep(nanoseconds: 1_000_000_000)
               return "2"
           }

           var value = [String]()
           for try await op in group {
               value.append(op)
           }
           return value
        }
        print("throwingTaskGroup", result)
    }
}

// MARK: - DiscardingTaskGroup、ThrowingDiscardingTaskGroup
extension ConcurrencyTutorial {
    
    /*
     DiscardingTaskGroup
     withDiscardingTaskGroup 类似于 withTaskGroup，但它不收集任务的返回值。这对于执行一组并发操作，而且你不关心它们的结果（或者结果通过其他方式处理），只是想要并发执行任务，这时使用
     withDiscardingTaskGroup 更为合适。

     public mutating func addTask(operation: @escaping @Sendable () async -> Void)

     其实如果这样看，可asyc let差不多，但是DiscardingTaskGroup能够以组的概念去管理
     */
    var discarding_task_group: some View {
        Button("DiscardingTaskGroup") {
            Task {
                await withDiscardingTaskGroup { group in
                    // 该方法不能有返回值，不然会报错
                    group.addTask {
                        // dome some thing
                    }
                }
            }
        }
    }
}

// MARK: - UnsafeCurrentTask
extension ConcurrencyTutorial {

    /*
     UnsafeCurrentTask 是 Swift 5.5 引入的一个 API，它提供了对当前执行的 Task 的低级访问。通过 UnsafeCurrentTask, 你可以访问和操作当前任务的一些属性，例如取消标志，但需要注意的是，这种访问是不安全的，因为它可能会导致竞态条件或其他并发问题。

     */
    var unsafeCurrentTask: some View {
        Button("UnsafeCurrentTask") {
            let result = withUnsafeCurrentTask { task in

                return "12"
            }
            print(result)
        }
    }
}

extension ConcurrencyTutorial.FileDownloader {

    func download(_ url: URL) -> AsyncThrowingStream<Status, Error> {
        return AsyncThrowingStream { continuation in
            do {
                try download(url, progressHandler: { progress in
                    continuation.yield(.downloading(progress))
                }, completion: { result in
                    switch result {
                    case .success(let data):
                        continuation.yield(.finished(data))
                        continuation.finish()
                    case .failure(let error):
                        continuation.finish(throwing: error)
                    }
                })
            } catch {
                continuation.finish(throwing: error)
            }
        }
    }
}

// MARK: - AsyncStream、AsyncThrowingStream
extension ConcurrencyTutorial {

    struct FileDownloader {
        enum Status {
            case downloading(Float)
            case finished(Data)
        }

        func download(_ url: URL, progressHandler: (Float) -> Void, completion: (Result<Data, Error>) -> Void) throws {
            // .. Download implementation
        }
    }

    var asyncStream: some View {
        Button("AsyncStream") {
            Task {
                do {
                    let downloader = FileDownloader()
                    let url = URL(string: "")!
                    for try await status in downloader.download(url) {
                        switch status {
                        case .downloading(let progress):
                            print("Downloading progress: \(progress)")
                        case .finished(let data):
                            print("Downloading completed with data: \(data)")
                        }
                    }
                    print("Download finished and stream closed")
                } catch {
                    print("Download failed with \(error)")
                }
            }
        }
    }
}

// MARK: - CheckedContinuation、UnsafeContinuation
extension ConcurrencyTutorial {

    /*
     这里其实可以看下：
     func withCheckedContinuation<T>(
         function: String = #function,
         _ body: (CheckedContinuation<T, Never>) -> Void
     ) async -> T
     
     func withCheckedThrowingContinuation<T>(
         function: String = #function,
         _ body: (CheckedContinuation<T, Error>) -> Void
     ) async throws -> T

     */
    var checkedContinuation: some View {
        Button("CheckedContinuation") {
            Task {
                let _ = await withCheckedContinuation { continuation in
                    continuation.resume(returning: "")
                }
            }
        }
    }
}

// MARK: - AnyActor、Actor、Sendable
extension ConcurrencyTutorial {
    
    var sendable: some View {
        Button("Sendable") {

        }
    }

    func sendable(operation: () -> Int) {

    }
}

// MARK: - GlobalActor、MainActor

#Preview {
    ConcurrencyTutorial()
}
