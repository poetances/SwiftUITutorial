//
//  AsyncSequencesTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/3/4.
//

import SwiftUI

/*
 TaskGroup: AsyncSequences
 所以TaskGroup是可以通过for循环进行遍历取值


 protocol AsyncSequence
 func makeAsyncIterator() -> Self.AsyncIterator // 必须实现的核心方法

 associatedtype AsyncIterator : AsyncIteratorProtocol
 protocol AsyncIteratorProtocol

 当然还有扩展方法：
 Find Elements
 Selecting Elements
 Excluding Elements
 Transforming Elements
 */
struct AsyncSequencesTutorial: View {
    var body: some View {
        VStack(spacing: 15) {
            taskgroup
        }
    }
}

// MARK: - TaskGroup
extension AsyncSequencesTutorial {

    var taskgroup: some View {
        Button("TaskGroup") {
            Task {
                await taskGroup()
            }
        }
    }

    func taskGroup() async {

        await withTaskGroup(of: String.self) { group in

        }
    }
}

// MARK: - AsyncStream
extension AsyncSequencesTutorial {

    /*
     init(
         _ elementType: Element.Type = Element.self,
         bufferingPolicy limit: AsyncStream<Element>.Continuation.BufferingPolicy = .unbounded,
         _ build: (AsyncStream<Element>.Continuation) -> Void
     )

     init(
         unfolding produce: @escaping () async -> Element?,
         onCancel: (() -> Void)? = nil
     )
     两种方式产生新元素，第二种方式produce的解释：
     Use this convenience initializer when you have an asynchronous function that can produce elements for the stream, and don’t want to invoke a continuation manually. This initializer “unfolds” your closure into an asynchronous stream. The created stream handles conformance to the AsyncSequence protocol automatically, including termination (either by cancellation or by returning nil from the closure to finish iteration).

     */
    var async_stream: some View {
        Button("AsyncStream") {
            Task {
                let fileDownloader = FileDownloader()
                let url = URL(string: "")!
                for try await result in fileDownloader.download(url) {
                    switch result {
                    case .downloading(let progress):
                        print("Progress", progress)
                    case .finish(let data):
                        print("Finish", data)
                    }
                }
            }
        }
    }
}

struct FileDownloader {
    enum Status {
        case downloading(Float)
        case finish(Data)
    }

    func download(_ url: URL, progressHandle: ((Float) -> Void)? = nil, completion: ((Result<Data, Error>) -> Void)? = nil) {
        // .. Download implementation
    }
}

extension FileDownloader {

    func download(_ url: URL) -> AsyncThrowingStream<Status, Error> {
        AsyncThrowingStream { continuation in
            download(url) { progress in
                continuation.yield(.downloading(progress))
            } completion: { result in
                switch result {
                case let .success(data):
                    continuation.yield(.finish(data))
                    continuation.finish()
                case let .failure(error):
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}

#Preview {
    AsyncSequencesTutorial()
}
