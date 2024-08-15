//
//  ObservationTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/1/21.
//

import SwiftUI
import Observation

/*
 https://fatbobman.com/zh/posts/mastering-observation/
 在 Swift 5.9 版本之前，苹果没有为开发者提供一种统一高效的机制来观察引用类型属性对变化。KVO 仅限于 NSObject 子类使用，Combine 无法提供属性级别的精确观察，而且两者都无法实现跨平台支持。

 同样Observable也是只能修饰class


 @Observable 附加宏。一般以@开头，其作用是增加代码。
 #preview 独立宏。一般以#开头，其作用是替换代码，跟oc中的宏是一样的。、

 ObserableObject 协议
 ObservedObject 结构体
 struct StateObject<ObjectType> where ObjectType : ObservableObject
 struct ObservedObject<ObjectType> where ObjectType : ObservableObject

 struct EnvironmentObject<ObjectType> where ObjectType : ObservableObject
 */
struct ObservationTutorial: View {
    private var car = Car(name: "凯迪拉克")

    var body: some View {
        Text(car.name).padding()
        Button("ListenObservable") {
            if #available(iOS 17.0, *) {
                withObservationTracking {
                    _ = car.name
                } onChange: {
                    print("Schedule renderer.", car.name)
                }
            } else {
            }
        }.padding()

        Button("Change Name") {
            car.name += "change"
        }

        Button("Change needsRepairs") {
            car.needsRepairs.toggle()
        }
    }
}

#Preview {
    ObservationTutorial()
}


@Observable
class Car {
    var name: String = ""
    var needsRepairs: Bool = false

    init(name: String, needsRepairs: Bool = false) {
        self.name = name
        self.needsRepairs = needsRepairs
    }
}
