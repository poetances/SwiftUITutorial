//
//  SubscriptionsTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/13.
//

import SwiftUI

/*
 protocol Subscription : Cancellable, CustomCombineIdentifierConvertible
 func request(Subscribers.Demand)

 enum Subscriptions
 static var empty: Subscription

 总的来说Subscription是配合Publisher使用的，作为Publisher和Subscriber的粘合剂，处理中间的数据逻辑。
 */
struct SubscriptionsTutorial: View {
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    SubscriptionsTutorial()
}
