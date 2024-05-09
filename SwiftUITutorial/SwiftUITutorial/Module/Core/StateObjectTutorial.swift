//
//  StateObjectTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2023/12/11.
//

import SwiftUI

/*
 @ObservedObject
 使用场景：当你的视图是暂时的或者是被其他视图拥有时，使用 @ObservedObject。这意味着视图本身不负责创建这个对象，只是用来观察和响应对象中的变化。
 对象所有权：视图不拥有 @ObservedObject 标记的对象。因此，对象可能由外部创建并通过视图的构造器传入。
 生命周期：该对象的生命周期需要开发者自己管理，SwiftUI 不会对其生命周期做出假设或自动化处理。
 
 @StateObject
 使用场景：当你希望视图拥有并负责初始化可观察对象时，使用 @StateObject。这意味着该对象是由视图直接创建的，并且与视图的生命周期密切相关。
 对象所有权：视图拥有 @StateObject 标记的对象，对象的生命周期由视图控制。
 生命周期：当视图首次初始化时，对象会被创建。即使视图因状态变化而重建，对象也不会被销毁和重新创建，它会一直存在直到视图从内存中被彻底移除。

 @State
 public var wrappedValue: Value { get nonmutating set }
 使用结构体，我们可以声明mutating的方法，但不能声明mutating的计算属性(如body)，也不能在其中调用mutating的方法。

 */
struct StateObjectTutorial: View {
    @StateObject var model = AppModel()

    var so: StateObject = StateObject(wrappedValue: AppModel())

    var body: some View {

        ScrollView {
            Text(Date.now, style: .date)

            Text("主视图 count: \(model.count)")
            Button("增加 count") {
                model.count += 1
            }

            NavigationLink("ChildView") {
                ChildView(model: model)
            }
            
        }
        .onChange(of: model.count) { oldValue, newValue in
            print(oldValue, newValue)
        }
    }
}

struct ChildView: View {

    @ObservedObject var model: AppModel

    init(model: AppModel) {
        self.model = model
    }

    var body: some View {
        Text("子视图 count: \(model.count)")
    }
}

struct ChildView2: View {

    @Binding var count: Int

    init(count: Binding<Int>) {
        _count = count
    }

    var body: some View {
        Text("子视图 count: \(count)")
    }
}



class AppModel: ObservableObject {


    @Published var count = 0

    init() {
        print("AppModel 初始化。当前 count 值为 \(count)")
    }

    deinit {
        print("AppModel 销毁。当前 count 值为 \(count)")
    }
}

// MARK: - 内部实现原理
final class Box<V>: ObservableObject {

    var value: V {
        willSet {
            objectWillChange.send()
        }
    }

    init(_ value: V) {
        self.value = value
    }
}
@propertyWrapper struct MState<V>: DynamicProperty {

    @StateObject private var box: Box<V>

    var wrappedValue: V {
        get {
            print("get::", box.value)
            return box.value
        }
        nonmutating set {
            box.value = newValue
            print("set::", newValue)
        }
    }

    init(wrappedValue value: V) {
        self._box = StateObject(wrappedValue: Box(value))
    }
}
