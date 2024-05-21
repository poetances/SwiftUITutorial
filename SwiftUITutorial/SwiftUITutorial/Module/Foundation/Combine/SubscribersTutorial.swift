//
//  SubscribersTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/9.
//

import SwiftUI

/*
 protocol Subscriber<Input, Failure> : CustomCombineIdentifierConvertible

 func receive(_ input: Self.Input) -> Subscribers.Demand
 func receive() -> Subscribers.Demand

 // life cycle event
 func receive(subscription: Subscription)
 func receive(completion: Subscribers.Completion<Self.Failure>)


 enum Subscribers
 struct Demand // Requesting Elements
 enum Completion // Receiving Life Cycle Events

 ---------------------------------------------------------------
 Using Convenience Subscribers

 A simple subscriber that requests an unlimited number of values upon subscription.
 Subscribers.Sink
 final class Sink<Input, Failure> where Failure : Error

 Subscribers.Assign
 final class Assign<Root, Input>
 */
struct SubscribersTutorial: View {
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    SubscribersTutorial()
}
