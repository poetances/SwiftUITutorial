//
//  ConcurrencyTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/1/31.
//

import SwiftUI

struct ConcurrencyTutorial: View {
    var body: some View {
        VStack(spacing: 15) {
            task
            task_cancellation
            taskGroup
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
     TaskGroup是通过withTaskGroup来创建。
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

#Preview {
    ConcurrencyTutorial()
}
