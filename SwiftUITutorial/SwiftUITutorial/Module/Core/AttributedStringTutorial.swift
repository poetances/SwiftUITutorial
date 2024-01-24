//
//  AttributedStringTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/1/24.
//

import SwiftUI

/*
 AttributedString，iOS15推出来的，用于替代NSAttributtedString
 */
struct AttributedStringTutorial: View {
    var body: some View {
        Text("Hello, World!").padding()

        Text(attributedString()).padding()

        Text(attributedContainer()).padding()
    }
}

extension AttributedStringTutorial {

    func attributedString() -> AttributedString {
        var attr = AttributedString("hello")
        attr.font = .callout
        attr.foregroundColor = .red

        var st = AttributedString("AttributedString")
        st.font = UIFont.systemFont(ofSize: 14)
        st.foregroundColor = UIColor.purple
        return attr + st
    }

    func attributedContainer() -> AttributedString {
        var attr = AttributedString("hello")

        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        container.foregroundColor = UIColor.red
        attr.setAttributes(container)

        return attr
    }

    /*
     attributedString.swiftUI.foregroundColor = .red
     attributedString.uiKit.foregroundColor = .red
     attributedString.appKit.foregroundColor = .red

     AttributeScope
     属性范围是系统框架定义的属性集合，将适合某个特定域中的属性定义在一个范围内，一方面便于管理，另一方面也解决了不同框架下相同属性名称对应类型不一致的问题。

     */
}

#Preview {
    AttributedStringTutorial()
}
