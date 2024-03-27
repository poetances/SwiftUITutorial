//
//  ContinuationsTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/3/4.
//

import SwiftUI

/*
 将任意任务转换成并发：
 CheckedContinuation
 withCheckedContinuation(function:_:)
 withCheckedThrowingContinuation(function:_:)

 UnsafeContinuation
 withUnsafeContinuation(_:)
 withUnsafeThrowingContinuation(_:)

 UnsafeContinuation和CheckedContinuation的主要区别就是：
 使用UnsafeContinuation是不安全的，因为它不会自动检查是否恰当地恢复了执行流。
 如果你忘记恢复执行或多次恢复执行，Swift的运行时不会提供错误或警告，这可能导致未定义行为或应用程序崩溃。

 也就是说一个Continuation，应该在一次执行中，必须只执行一次resume
 */
struct ContinuationsTutorial: View {

    private var age = 11

    // MARK: - system
    var body: some View {
        VStack {
            Button("Checked") {
                Task {
                    await checkedContinuation()
                }
            }
        }
    }
}

extension ContinuationsTutorial {

    func checkedContinuation() async -> String {
        await withCheckedContinuation { continuation in

            // 这是正确情况，即整个闭包执行一次，只会resume一次
            if age > 12 {
                // ..... do some thing
                continuation.resume(returning: ">12")
            } else {
                continuation.resume(returning: "<=12")
            }

            // 如下操作，将会收到警告
//            if age > 12 {
//                // ..... do some thing
//                continuation.resume(returning: ">12")
//                continuation.resume(returning: "<=12")
//            } else {
//
//            }
        }
    }
}

#Preview {
    ContinuationsTutorial()
}
