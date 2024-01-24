//
//  ResultBuildTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2023/12/13.
//

import SwiftUI

/// 常见的ResultBuilder包括：SceneBuilder、ViewBuilder。主要使用DSL
struct ResultBuildTutorial: View {
    var body: some View {
        Text("Hello, World!").padding()

        Button("action") {
            let result = testStringBuilder(input: 2)
            print(result)
        }

        Button("action2") {
            let result = testStringBuilder2 {
                "隐士"
                "调用"
            }
            print(result)
        }.padding()

        Button("action3") {
            let result = testStringBuilder3
            print(result)
        }.padding()
    }
}

extension ResultBuildTutorial {

    //可以采用显式的方式来调用构建器，例如：
    @StringBuilder
    func testStringBuilder(input: Int) -> String {
        if input == 0 {
            "hello"
            "stringBuilder"
        } else if input == 1 {
            "input == 1"
        } else {
            "input == 2"
        }

        for index in 0...input {
            "for in \(index)"
        }
    }
    //也可以采用隐式的方式调用构建器：
    func testStringBuilder2(@StringBuilder _ content: () -> String) -> String {
        content()
    }

    @StringBuilder
    var testStringBuilder3: String {
        "属性"
        "调用"
    }
}


#Preview {
    ResultBuildTutorial()
}

@resultBuilder 
struct VStackBuilder {

    static func buildBlock(_ components: UIView...) -> [UIView] {
        components
    }
}

@resultBuilder
struct StringBuilder {
    // 用来构建语句块的组合结果。每个结果构建器至少要提供一个它的具体实现。
    static func buildBlock(_ components: String...) -> String {
        components.joined(separator: ",")
    }

    /*
     用于处理在特定执行中可能或不可能出现的部分结果。当一个结果构建器提供了 buildOptional(_:) 时，转译后的函数可以使用没有 else 的 if 语句，同时也提供了对 if let 的支持。
     即，如果component为假，同样还是可以运行，返回“null”
     */
    static func buildOptional(_ component: String?) -> String {
        component ?? "null"
    }

    /*
     用于在选择语句的不同路径下建立部分结果。当一个结果构建器提供这两个方法的实现时，转译后的函数可以使用带有 else 的 if 语句以及 switch 语句。

     同时发现，只有调用else if才会调用buildEither(first: Component)，否则直接调static func buildEither(second component: String)
     */
    static func buildEither(first component: String) -> String {
        component
    }
    static func buildEither(second component: String) -> String {
        component
    }

    /*
     用来从一个循环的所有迭代中收集的部分结果。在一个结果构建器提供了 buildArray(_:) 的实现后，转译后的函数可以使用 for...in 语句。
     */
    static func buildArray(_ components: [String]) -> String {
        components.joined(separator: ",")
    }


    /*
     用于将 buildBlock 在受限环境下（例如 if #available）产生的部分结果转化为可适合任何环境的结果，以提高 API 的兼容性。
     */
    static func buildLimitedAvailability(_ component: String) -> String {
        component
    }
}
