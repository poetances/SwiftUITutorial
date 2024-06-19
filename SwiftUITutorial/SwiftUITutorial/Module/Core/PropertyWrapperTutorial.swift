//
//  PropertyWrapperTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2023/12/13.
//

import SwiftUI


extension Sequence {

    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        map { $0[keyPath: keyPath] }
    }

    func sorted<T: Comparable>(_ keyPath: KeyPath<Element, T>) -> [Element] {
        sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}


// 属性包装器一定要有wrappedValue
@propertyWrapper
struct Wrapper<T> {
    var wrappedValue: T

//    init(_ value: T) {
//        self.wrappedValue = value
//    }
}

/// swift中常见的属性包装器包括：@State、@Binding、@StateObjce、@ObservaObject、@Published、
/// @Environment、@EnvironmentObject、@AppStore、@SceneStore
struct PropertyWrapperTutorial: View {

    // 两种属性包装器的赋值是一样的。
    @State private var age = 12
    @State(wrappedValue: 12) private var age2

    // 默认这种方式的初始化就是调用init(wrappedValue: T)方法
    @Wrapper private var name = "Wrapper"
    @Wrapper(wrappedValue: "Wrapper") private var name2

    var body: some View {
        VStack(spacing: 10) {
            Button("Wrapper") {

            }
        }
    }
}

#Preview {
    PropertyWrapperTutorial()
}

// 关于Environment怎么理解
struct MyEnvironmentKey: EnvironmentKey {
    static var defaultValue: String = ""
}

extension EnvironmentValues {
    
    var myCustomValue: String {
        get {
            self[MyEnvironmentKey.self]
        }
        set {
            self[MyEnvironmentKey.self] = newValue
        }
    }
}

struct _MyView: View {
    var body: some View {
        Text("MyView")
            .environment(\.myCustomValue, "MyViewCustom")
    }
}

struct _OtherMyView: View {
    @Environment(\.myCustomValue) private var customValue

    var body: some View {
        Text("Other My View:::\(customValue)")
    }
}
