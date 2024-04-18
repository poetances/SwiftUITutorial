//
//  AppStorageTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/4/16.
//

import SwiftUI


/*
 
 @frozen @propertyWrapper public struct AppStorage<Value> : DynamicProperty {

     public var wrappedValue: Value { get nonmutating set }

     public var projectedValue: Binding<Value> { get }
 }

 因为遵循DynamicProperty，所以其值更改，那么UI也会刷新。
 注意：
 @AppStorage("name") private var name = "Gust"
 当第一次启动时候，let name = UserDefaults.standard.string(forKey: "name")获取的name为空。
 因为默认值，只是给了name一个默认值，如果当前key = "name"没有值时候，则会使用默认值

 从初始化方法，我们可以看出: AppStorage支持的Value类型有：
 String、Int、Data、RawRepresentable、URL、Double、Bool等
 */
struct AppStorageTutorial: View {
    // 注意这两个写法等价，这也是PropertyValue的核心思想
    @AppStorage("count") private var count = 0
    @AppStorage(wrappedValue: 0, "count2") private var count2

    var body: some View {
        VStack {
            Text("\(count)")
            Button("Add Count") {
                count += 1
            }
            AppStorageContent(count: $count)
        }
    }
}

struct AppStorageContent: View {
    @Binding var count: Int

    var body: some View {
        Button("Child Add Count") {
            count += 1
        }
    }
}

#Preview {
    AppStorageTutorial()
}
