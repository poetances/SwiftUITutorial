//
//  TaskLocalTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/3/13.
//

import SwiftUI

/*
 @propertyWrapper
 final class TaskLocal<Value> where Value : Sendable

 A task-local value is a value that can be bound and read in the context of a Task. It is implicitly carried with the task, and is accessible by any child tasks the task creates (such as TaskGroup or async let created tasks).

 TaskLocal作用：就是跟当前Task绑定，实现传值。
 也就是，每个Task绑定一个值，然后以链表的方式存储。似乎我们使用的场景不多。
 */
struct TaskLocalTutorial: View {

    @TaskLocal
    static var traceID = ""

    static var noTraceId = ""
    // MARK: - private
    var body: some View {
        VStack(spacing: 15) {

            Button("Normal") {
                TaskLocalTutorial.noTraceId = "Send"
                callNo()
                call()

                Task {
                    callNo()
                    call()
                }

                Task.detached {
                    otherCallNo()
                    otherCall()
                }
            }

            Button("TaskLocal") {
                TaskLocalTutorial.$traceID.withValue("NewValue") {
                    callNo()
                    call()

                    Task {
                        callNo()
                        call()
                    }

                    Task.detached {
                        otherCallNo()
                        otherCall()
                    }
                }
            }

        }
    }

    func call() {
        print("traceID: \(TaskLocalTutorial.traceID)")
    }

    func otherCall() {
        print("otherCall traceID: \(TaskLocalTutorial.traceID)")
    }


    func callNo() {
        print("callNo-traceID: \(TaskLocalTutorial.noTraceId)")
    }

    func otherCallNo() {
        print("otherCallNo-traceID: \(TaskLocalTutorial.noTraceId)")
    }

}

#Preview {
    TaskLocalTutorial()
}
