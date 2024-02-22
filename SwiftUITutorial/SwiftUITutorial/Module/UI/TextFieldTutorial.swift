//
//  TextFieldTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/21.
//

import SwiftUI

/*
 TextField主要就是几个参数：
 title、label、prompt占位符
 axis滚动方向
 format这个和Text类似，都是修改展示样式的

 TextFieldStyle：
 DefaultTextFieldStyle
 PlainTextFieldStyle
 RoundedBorderTextFieldStyle
 SquareBorderTextFieldStyle macos
 */
struct TextFieldTutorial: View {

    @State private var textfield = ""

    @State private var selectedDate: Date = Date()
    @State private var myDouble: Double = 0.673

    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {
            textField
            textField_prompt
            text_label
            text_axis
            text_format
        }
        .padding()
        .font(.title3)
    }
}

// MARK: - Creating a text field with a string
extension TextFieldTutorial {

    var textField: some View {
        TextField("TextField", text: $textfield)
    }

    // prompt可以修改占位内容样式
    var textField_prompt: some View {
        VStack(content: {
            TextField("TextFieldPrompt", text: $textfield, prompt: Text("Prompt"))
            TextField("TextFieldPrompt2",
                      text: $textfield,
                      prompt: Text("Prompt").fontWeight(.bold).foregroundStyle(.red)
            )
        })
        .padding()
        .border(.red)
    }

    // TextLabel是和prompt互斥的。而且Prompt优先级更高
    var text_label: some View {
        VStack {
            TextField(text: $textfield) {
                Text("TextLabel")
            }

            TextField(text: $textfield, prompt: Text("Prompt")) {
                Text("TextLabel")
            }
        }
    }
}

// MARK: - creating a scrollable textfield
extension TextFieldTutorial {

    /*
     Axis表明了方向，默认是horizontal，即当文本超过限制时候是水平滚动还是竖直滚动
     但是没有滚动条
     */
    var text_axis: some View {
        VStack {
            TextField("Textfield", text: $textfield, axis: .vertical)
                .padding()
                .border(.red)
                .frame(height: 90)

            TextField(text: $textfield, axis: .horizontal) {
                Text("Label")
            }
        }
    }
}

// MARK: - creating a text field formate
extension TextFieldTutorial {

    /*
     format是修饰value的，通知这种情况下，一般会通过 onSubmit(of:_:)来更改显示内容。

     Use this initializer to create a text field that binds to a bound value, using a ParseableFormatStyle to convert to and from this type. Changes to the bound value update the string displayed by the text field. Editing the text field updates the bound value, as long as the format style can parse the text. If the format style can’t parse the input, the bound value remains unchanged.
     输入的内容必须符合formate，不然不会更新value的值。
     */
    var text_format: some View {

        VStack {
            TextField("Format", value: $selectedDate, format: .dateTime.year().month().day())
                .onSubmit(of: .text) {

                }

            TextField("Format", value: $myDouble, format: .number)
                .textFieldStyle(.roundedBorder)
        }
    }
}

#Preview {
    TextFieldTutorial()
}
