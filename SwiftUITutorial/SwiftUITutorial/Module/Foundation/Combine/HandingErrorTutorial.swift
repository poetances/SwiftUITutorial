//
//  HandingErrorTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/21.
//

import SwiftUI
import Combine

struct HandingErrorTutorial: View {

    @State private var bags = Set<AnyCancellable>()
    var body: some View {
        List {
            assertNoFailure
            `catch`
            retry
        }
        .navigationTitle("HandingError")
    }
}

extension HandingErrorTutorial {

    // MARK: - assertNoFailure(_:file:line:)
    /// Use assertNoFailure() for internal integrity checks that are active during testing. However, it is important to note that, like its Swift counterpart fatalError(_:), the assertNoFailure() operator asserts a fatal exception when triggered during development and testing, and in shipping versions of code.
    var assertNoFailure: some View {
        Button("AssetNoFailure") {
            enum SubjectError: Error {
                case genericSubjectError
            }

            let subject = CurrentValueSubject<String, Error>("initial value")
            subject.assertNoFailure()
                .sinkAutoPrint()
                .store(in: &bags)

            subject.send("Second value")
            subject.send(completion: .failure(SubjectError.genericSubjectError))
        }
    }

    // MARK: - func `catch`<P>(_ handler: @escaping (Self.Failure) -> P) -> Publishers.Catch<Self, P> where P : Publisher, Self.Output == P.Output
    /// Use catch() to replace an error from an upstream publisher with a new publisher.
    var `catch`: some View {
        Button("Catch") {
            struct SimpleError: Error {}
            let numbers = [5, 4, 3, 2, 1, 0, 9, 8, 7, 6]
            numbers.publisher
                .tryLast {
                    guard $0 != 0 else {throw SimpleError()}
                    return true
                }
                .catch { _ in Just(-1) }
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }

    // MARK: - func retry(_ retries: Int) -> Publishers.Retry<Self>
    /// Use retry(_:) to try a connecting to an upstream publisher after a failed connection attempt.
    /// 在 Combine 框架中，Retry 是一个操作符，用于在发布者（Publisher）发生错误时重新尝试执行操作。Retry 操作符会重新订阅原始的发布者，并重新开始执行其操作。你可以指定重试的次数，或者在无限次重试的情况下，直到成功为止。
    var retry: some View {
        Button("Retry") {
            let publisher = Just<Int>(2)
                .tryMap { value -> Int in
                    if value == 2 {
                        throw NSError(domain: "example", code: 0, userInfo: nil) // 模拟一个错误
                    }
                    return value
                }

            publisher
                .print("Retry Example")
                .retry(3)
                .sinkAutoPrint()
                .store(in: &bags)
        }
    }
}

#Preview {
    HandingErrorTutorial()
}
