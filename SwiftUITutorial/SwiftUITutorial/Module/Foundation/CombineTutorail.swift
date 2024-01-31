//
//  CombinePage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/1/5.
//

import SwiftUI
import Combine
/*
Publisher协议、里面有很多operator方法，每个方法返回的还是一个Publisher，而且是放在
 Publishers枚举里面。

 Published里面有个projectValue是一个Publisher

 ObservableObject是一个协议，里面有一个objceWillChange是一个ObserableObjectPublisher


 https://fatbobman.com/zh/posts/mastering-observation/
 在 Swift 5.9 版本之前，苹果没有为开发者提供一种统一高效的机制来观察引用类型属性对变化。KVO 仅限于 NSObject 子类使用，Combine 无法提供属性级别的精确观察，而且两者都无法实现跨平台支持。

 此外，在 SwiftUI 中，引用类型的数据源（Source of Truth）采用了基于 Combine 框架的 ObservableObject 协议实现。这导致在 SwiftUI 中，极易产生了大量不必要的视图刷新，从而影响 SwiftUI 应用的性能。

 为了改善这些限制，Swift 5.9 版本推出了 Observation 框架。相比现有的 KVO 和 Combine，它具有以下优点：

 适用于所有 Swift 引用类型，不限于 NSObject 子类，提供跨平台支持。
 提供属性级别的精确观察，且无需对可观察属性进行特别注解。
 减少 SwiftUI 中对视图的无效更新，提高应用性能。
 */

struct CombineTutorail: View {

    // MARK: - private
    @State private var cancelables = Set<AnyCancellable>()

    // MARK: - system
    var body: some View {
        ScrollView {
            VStack {
                Button("Future") {

                    future().sink { value in
                        print(value, Thread.current)
                    }.store(in: &cancelables)
                }.padding()
            }
        }
        .navigationTitle("Combine")
        // .navigationBarBackButtonHidden()
    }
}

private extension CombineTutorail {

    func future() -> Future<Int, Never> {
        Future { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
                let value = Int.random(in: 1...10)
                promise(.success(value))
            }
        }
    }

    func just() {

    }
}

#Preview {
    CombineTutorail()
}

@Observable
class Store {
    var firstName: String = "Yang"
    var lastName: String = "Xu"
    var fullName: String {
        firstName + " " + lastName
    }

    @ObservationIgnored
    private var count: Int = 0

    init(firstName: String, lastName: String, count: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.count = count
    }
}
