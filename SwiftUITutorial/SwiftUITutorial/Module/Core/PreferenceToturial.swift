//
//  PreferenceToturial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/5.
//

import SwiftUI

/*
 在SwiftUI中，父View可以分享environment给子View使用，同时订阅environment的变化，但是有时候子View需要传递数据给父View，在SwiftUI这种情况通常使用Preferences。

 PreferenceKey 的示例使用之一是 NavigationStack 和 navigationTitle。 navigationTitle 不会直接修改导航视图，而是使用 PreferenceKey 来传达标题更改。

 */
struct PreferenceToturial: View {

    private let messages: [String] = ["one","two","three"]

    @State private var inputText = ""

    // MARK: - system
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            ZStack {
                Text(inputText)
                    .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds, transform: { $0 })
            }
            .overlayPreferenceValue(BoundsPreferenceKey.self, { value in
                GeometryReader(content: { geometry in
                    value.map {
                        Rectangle()
                            .stroke()
                            .frame(
                                width: geometry[$0].width,
                                height: geometry[$0].height
                            )
                            .offset(
                                x: geometry[$0].minX,
                                y: geometry[$0].minY
                            )
                    }
                })
            })


            TextField("input pwd", text: $inputText)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 20)
            List(messages, id: \.self) { message in
                Text(message)
            }
            .preference(key: NavigationTitlePreferenceKey.self, value: "message")
            .transformPreference(NavigationTitlePreferenceKey.self, { value in
                value += " transform"
            })

        }
        .onPreferenceChange(NavigationTitlePreferenceKey.self, perform: { value in
            print("NavigationTitlePreferenceKey", value)
        })
    }
}


/*
 preference(key:value:)
 func transformPreference<K>(
     _ key: K.Type = K.self,
     _ callback: @escaping (inout K.Value) -> Void
 ) -> some View where K : PreferenceKey
 */
struct NavigationTitlePreferenceKey: PreferenceKey {

    static var defaultValue = ""

    /*
     reduce方法在Swift中非常常见，这里的用处是当有多个子View都给父View传递数据时，父View最后是只能接受一个数据，而reduce就是将子View提供的多个数据进行“操作”，降维为一个数据提供给父View使用，PreferenceKey的reduce方法包含两个参数：当前的value，和下一个要合并的值nextValue，这二个参数是子View从上到下提供的。

     上面代码中List根据messages数组的个数循环显示Text文本，每个Text文本都调用了preference(key: value:)方法来向父View提供title数据，当父View调用onPreferenceChange方法时，会触发对应的PreferenceKey中的reduce方法（不调用是不会触发的），这里是简单的返回了nextValue，也就是List中最后一个Text发出的title值（打印three）。
     */
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

/*
 func anchorPreference<A, K>(
     key _: K.Type = K.self,
     value: Anchor<A>.Source,
     transform: @escaping (Anchor<A>) -> K.Value
 ) -> some View where K : PreferenceKey

 func transformAnchorPreference<A, K>(
     key _: K.Type = K.self,
     value: Anchor<A>.Source,
     transform: @escaping (inout K.Value, Anchor<A>) -> Void
 ) -> some View where K : PreferenceKey


 Anchor的使用：Anchor<CGRect>类型是用于在父视图或其他视图的坐标空间中引用一个视图的位置或尺寸。要有效使用它，通常需要在另一个视图中通过.overlay、.background等修饰符和GeometryReader来解析这个Anchor<CGRect>。
 所以要注意里面的细节使用
 */
struct BoundsPreferenceKey: PreferenceKey {

    static var defaultValue: Anchor<CGRect>? = nil
    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = nextValue()
    }
}


#Preview {
    PreferenceToturial()
}

