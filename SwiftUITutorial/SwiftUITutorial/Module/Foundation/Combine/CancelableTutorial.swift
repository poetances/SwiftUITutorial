//
//  CancelableTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/9.
//

import SwiftUI

/*
 protocol Cancellable

 func cancel()
 func store<C>(in: inout C)
 func store(in: inout Set<AnyCancellable>)

 final class AnyCancellable: Cancellable ,Equatable, Hashable
 */
struct CancelableTutorial: View {
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    CancelableTutorial()
}
