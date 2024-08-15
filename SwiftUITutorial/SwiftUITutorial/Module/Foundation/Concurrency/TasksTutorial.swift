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
            task_group
            task_group2
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
                        print("Task1", Date.now)
                        return "1"
                    }

                    group.addTask {
                        try? await Task.sleep(nanoseconds: 3_000_000_000)
                        print("Task2", Date.now)
                        return "3"
                    }

                    print("Group end1", Date.now)
                    var results = [String]()
                    for await result in group {
                        results.append(result)
                    }
                    print("Group end2", Date.now)
                    return results
                }
                print("Result", Date.now)
                print(results)
                /*
                 Group end1 2024-08-15 07:41:30 +0000
                 Task1 2024-08-15 07:41:31 +0000
                 Task2 2024-08-15 07:41:33 +0000
                 Group end2 2024-08-15 07:41:33 +0000
                 Result 2024-08-15 07:41:33 +0000
                 */
            }
        }
    }

    /*
     struct DiscardingTaskGroup
     注意和TaskGroup不同，DiscardingTaskGroup是没有继承AsyncSequene

     func withDiscardingTaskGroup<GroupResult>(
         returning returnType: GroupResult.Type = GroupResult.self,
         body: (inout DiscardingTaskGroup) async -> GroupResult
     ) async -> GroupResult
     从这个定义我们是可以知道，DiscardingTaskGroup其实是少了childTaskResultType，所以子Task是没有返回结果的

     */
    var task_group2: some View {
        Button("TaskGroup2") {
            Task {
                let result = await withDiscardingTaskGroup { group in
                    group.addTask {
                        try? await Task.sleep(nanoseconds: 1_000_000_000)
                        print("Task1", Date.now)
                    }

                    group.addTask {
                        try? await Task.sleep(nanoseconds: 3_000_000_000)
                        print("Task2", Date.now)
                    }
                    print("Group end", Date.now)
                    return 12
                }
                print("Result", Date.now)
                print(result)
                /*
                 Group end 2024-08-15 07:39:21 +0000
                 Task1 2024-08-15 07:39:22 +0000
                 Task2 2024-08-15 07:39:24 +0000
                 Result 2024-08-15 07:39:24 +0000
                 */
            }
        }
    }
}

#Preview {
    TasksTutorial()
}
