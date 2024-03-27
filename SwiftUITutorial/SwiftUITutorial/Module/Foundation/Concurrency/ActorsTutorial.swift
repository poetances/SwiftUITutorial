//
//  ActorsTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/3/4.
//

import SwiftUI

/*
 Sendable用于标记一个类型是安全发送到并发上下文的。

 @Sendable 属性修饰符用于函数和闭包，表示该函数或闭包是并发安全的，可以安全地在并发上下文中调用。这意味着函数内部不会访问或修改任何外部的非并发安全状态，尤其是共享状态。对于异步函数（使用 async 关键字的函数）和全局函数，默认情况下是并发安全的，因此不需要显式地使用 @Sendable。但对于闭包，尤其是在可能会捕获并修改外部状态的情况下，使用 @Sendable 来明确标记其并发安全性是非常重要的。

 如果我们在编程的时候不写，只是说编译器不会强制要求我们的代码是并发安全的，不影响结果，但是代码可能就不太清晰明确。

 protocol Actor : AnyActor
 protocol AnyActor : AnyObject, Sendable
 The Actor protocol generalizes over all actor types. Actor types implicitly conform to this protocol.
 从上面可以看出几个重点：
 1、Actor： 遵循Sendable的，而且遵循AnyObject.
 2、使用actor修饰的类，隐士的遵循Actor协议。
 actor 类似于类 (class)，但它是为了解决并发访问共享数据的安全问题而设计的。在多线程环境中，不同的线程可能会同时访问和修改同一个对象的数据，这可能导致数据竞争、死锁等问题。actor 通过确保其内部状态的访问和修改只能在一个线程中异步进行来避免这类问题，从而提供了数据一致性和线程安全性。

 @globalActor
 final actor MainActor
 A singleton actor whose executor is equivalent to the main dispatch queue.
 之所以是个单利，因为遵循了GlobalActor
 */
struct ActorsTutorial: View {

    private let account = BankAccount(initialBalance: 100)
    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {
            Button("存入") {
                Task {
                    await account.deposit(amount: 50)
                    print("任务 1 当前余额：\(await account.getBalance())")
                }
            }

            Button("取出") {
                Task {
                    let success = await account.withdraw(amount: 30)
                    if success {
                        print("任务 2 成功取款，当前余额：\(await account.getBalance())")
                    }
                }
            }

            Button("存入") {
                Task {
                    await account.deposit(amount: 100)
                    print("任务 3 当前余额：\(await account.getBalance())")
                }
            }

            Button("查询") {
                Task {
                    let value = await account.getBalance()
                    print(value)
                }
            }
        }
    }
}

#Preview {
    ActorsTutorial()
}

actor BankAccount {
    private var balance: Double // 账户余额

    init(initialBalance: Double) {
        self.balance = initialBalance
    }

    // 存款方法
    func deposit(amount: Double) {
        balance += amount
        print("存入 \(amount)，新余额：\(balance)")
    }

    // 取款方法
    func withdraw(amount: Double) -> Bool {
        if amount > balance {
            print("余额不足，无法取款")
            return false
        } else {
            balance -= amount
            print("取出 \(amount)，新余额：\(balance)")
            return true
        }
    }

    // 获取当前余额
    func getBalance() -> Double {
        return balance
    }
}
