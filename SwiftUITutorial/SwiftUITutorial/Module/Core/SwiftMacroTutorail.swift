//
//  SwiftMacroTutorail.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/1/18.
//

import SwiftUI
import Observation
import Combine

/*
 https://www.cnswift.org/macros
 宏在编译源代码时可以对其进行转换，以避免手动编写重复的代码。在编译过程中，Swift 会在构建代码之前展开代码中的所有宏。
 宏的展开始终是一项增量操作：宏会添加新的代码，但不会删除或修改现有的代码。

 1、独立宏，声明的时候使用 @freestanding 关键字，使用的时候以标签 (#) 开头，并在后边的括号里添加相应的参数，主要作用是代替代码中的内容，有点像 OC 的宏，比如官方示例中的 #stringify(a + b)，或者 #warning("这是一个警告")。
 2、附加宏，声明的时候使用 @attached 关键字，使用的时候以 @ 开头，并在后边的括号里添加相应的参数，主要作用是为声明添加代码，比如 @OptionSet<Int>。
 */
struct SwiftMacroTutorail: View {
    var body: some View {
        Text("Hello, World!")
    }
}

/// 独立宏
#Preview {
    SwiftMacroTutorail()
}

/// 可以增加名字
#Preview("Other", body: {
    SwiftMacroTutorail()
})

/// 指定方向
#Preview("Second", traits: .landscapeLeft, body: {
    SwiftMacroTutorail()
})


/// 附加宏
@Observable
class ObservationPerson {
    var name = "Observation"
    var count = 1

    @ObservationIgnored
    private var version = "swift 5.9"

}


class CombinePerson: ObservableObject {

    @Published var name = "Combine"
    @Published var count = 1
}


// 附加宏。附加宏是绑定到特定声明（如属性、方法、类、结构体等）上的宏。
// 它们用于修改或扩展这些声明的行为或属性。
/*
 @attached(member, names: named(myFunction))
 macro MyAttachedMacro() = #externalMacro(module: "SwiftUITutorial", type: "MyAttachedStruct")

 @MyAttachedMacro
 struct MyAttachedStruct {
     var myProperty: Int
 }
 */
