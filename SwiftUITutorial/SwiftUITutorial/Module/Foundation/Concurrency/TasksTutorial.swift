//
//  TasksTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/3/4.
//

import SwiftUI

struct TasksTutorial: View {

    var body: some View {
        VStack(spacing: 15) {
            task
            task_detached
            task_cancel
            task_yield
            task_sleep
        }
    }
}

// MARK: - Task
extension TasksTutorial {

    var task: some View {
        Button("Task") {
            Task {

            }
        }
    }

    /*
     相对Task
     Don’t use a detached task if it’s possible to model the operation using structured concurrency features like child tasks. Child tasks inherit the parent task’s priority and task-local storage, and canceling a parent task automatically cancels all of its child tasks. You need to handle these considerations manually with a detached task.

     也就是尽量不要使用Task.detached
     */
    var task_detached: some View {
        Button("TaskDetached") {
            Task.detached {

            }
        }
    }


    /*
     var isCancelled: Bool { get }
     func cancel()
     static func checkCancellation() throws

     如果取消，返回CancellationError

     withTaskCancellationHandler(operation:onCancel:)
     withTaskCancellationHandler(handler:operation:)
     */
    var task_cancel: some View {
        Button("TaskCancel") {
            Task {
                await withTaskCancellationHandler {

                } onCancel: {
                    print("on cancel")
                }
            }
        }
    }

    var task_yield: some View {
        Button("Yield") {
            Task {
                for i in 0..<10 {
                    print("Task iteration \(i)")

                    // 在每次迭代中调用 Task.yield()，让出执行权
                    await Task.yield()

                    // 假设这里有一些耗时的操作
                    try? await Task.sleep(nanoseconds: 100_000_000) // 等待0.1秒
                }
            }
        }
    }

    var task_sleep: some View {
        Button("Sleep") {
            Task {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
            }
        }
    }
}

// MARK: - TaskGroup
extension TasksTutorial {

    /*
     struct TaskGroup<ChildTaskResult> where ChildTaskResult : Sendable

     Conforms To
     AsyncSequence
     Conforms when ChildTaskResult conforms to Sendable.

     这也是TaskGroup: AsyncSequence，可以进行循环遍历的原因。

     @inlinable public func withTaskGroup<ChildTaskResult, GroupResult>(of childTaskResultType: ChildTaskResult.Type, returning returnType: GroupResult.Type = GroupResult.self, body: (inout TaskGroup<ChildTaskResult>) async -> GroupResult) async -> GroupResult where ChildTaskResult : Sendable
     一般不直接创建，而是通过withTaskGroup的方式创建
     */
    var task_group: some View {
        Button("TaskGroup") {
            Task {
                let results = await withTaskGroup(of: String.self) { group in
                    group.addTask {
                        try? await Task.sleep(nanoseconds: 1_000_000_000)
                        return "1"
                    }

                    group.addTask {
                        try? await Task.sleep(nanoseconds: 3_000_000_000)
                        return "3"
                    }

                    var results = [String]()
                    for await result in group {
                        results.append(result)
                    }
                    return results
                }
                print(results)
            }
        }
    }

    /*
     相对应的还有：TaskGroup、ThrowingTaskGroup、DiscardingTaskGroup
     */
}

#Preview {
    TasksTutorial()
}
