//
//  PropertyWrapperTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2023/12/13.
//

import SwiftUI

/// swift中常见的属性包装器包括：@State、@Binding、@StateObjce、@ObservaObject、@Published、
/// @Environment、@EnvironmentObject、@AppStore、@SceneStore
struct PropertyWrapperTutorial: View {

    var body: some View {
        Text("Hello, World!")
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
