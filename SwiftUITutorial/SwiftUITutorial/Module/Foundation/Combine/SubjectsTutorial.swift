//
//  SubjectsTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/29.
//

import SwiftUI
import Combine

struct SubjectsTutorial: View {

    @State private var bags = Set<AnyCancellable>()
    var body: some View {
        List {
            currentValueSubject
            passthroughSubject
        }
        .navigationTitle("Subject")
    }
}

extension SubjectsTutorial {

    // MARK: - final class CurrentValueSubject<Output, Failure> where Failure : Error
    var currentValueSubject: some View {
        Button("CurrentValueSubject") {
            let subject = CurrentValueSubject<String, Never>("One")
            subject.sinkAutoPrint().store(in: &bags)

            subject.send("Two")
            subject.send(completion: .finished)
        }
    }

    // MARK: - final class PassthroughSubject<Output, Failure> where Failure : Error
    var passthroughSubject: some View {
        Button("PassthroughSubject") {
            let subject = PassthroughSubject<Int, Never>()
            subject.send(1)

            // 订阅后才能收到值
            subject.sinkAutoPrint().store(in: &bags)
            subject.send(2)
            subject.send(3)
            subject.send(completion: .finished)
        }
    }
}

#Preview {
    SubjectsTutorial()
}
