//
//  TextTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/21.
//

import SwiftUI

/*
 Text
 A view that displays one or more lines of read-only text.

 You can create a Text view with the Markdown-formatted base language version of the string as the localization key.
 Text支持markdown

 Text doesn’t render all styling possible in Markdown. It doesn’t support line breaks, soft breaks, or any style of paragraph- or block-based formatting like lists, block quotes, code blocks, or tables. It also doesn’t support the imageURL attribute. Parsing with SwiftUI treats any whitespace in the Markdown string as described by the AttributedString.MarkdownParsingOptions.InterpretedSyntax.inlineOnlyPreservingWhitespace parsing option.

 Text不支持所有的Markdown样式，详细的可以使用AttributedString

 Text有一个方法使其可以直接使用+
 static func + (lhs: Text, rhs: Text) -> Text

 textSelection(_:)
 用于支持Text的选择
 */
struct TextTutorial: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                text
                    .textScale(.default)
                    .dynamicTypeSize(.small)
                text_verbatim
                text_attibutedstring
                text_markdown
                text_date_interval
                text_date_range
                text_date_style
                text_formatting
                text_image
                text_font
                text_style
            }
        }
        .textSelection(.enabled)

    }
}

// MARK: - Creat text with string
extension TextTutorial {

    var text: some View {
        Text("Placeholder")
    }

    var text_verbatim: some View {
        Text(verbatim: "pencil") // Displays the string "pencil" in any locale.
    }
}

// MARK: - Creat text with AttributedString
extension TextTutorial {

    /*
     Use this initializer to style text according to attributes found in the specified AttributedString. Attributes in the attributed string take precedence over styles added by view modifiers. For example, the attributed text in the following example appears in blue, despite the use of the foregroundColor(_:) modifier to use red throughout the enclosing VStack:

     主要意思就是Attributedstring，其特性的优先级更高
     */
    var content: AttributedString {
        var attributedString = AttributedString("Blue text")
        attributedString.foregroundColor = .blue
        attributedString.inlinePresentationIntent = .stronglyEmphasized
        return attributedString
    }

    var content1: AttributedString {
        var attributedString = AttributedString("Blue text")
        attributedString.inlinePresentationIntent = .stronglyEmphasized
        return attributedString
    }

    /*
     SwiftUI combines text attributes with SwiftUI modifiers whenever possible. For example, the following listing creates text that is both bold and red:
     */
    var text_attibutedstring: some View {
        VStack {
            Text(content)
            Text(content1)
            Text("Red Text")
        }
        .foregroundStyle(.red)
    }

    /*
     You can create an AttributedString with Markdown syntax, which allows you to style distinct runs within a Text view:
     */
    var content2: AttributedString {
        try! AttributedString(
           markdown: "**Thank You!** Please visit our [website](http://example.com)."
       )
    }
    var text_markdown: some View {
        Text(content2)
    }
}

// MARK: - Creating text view for a date
extension TextTutorial {

    /*
     DateInterval，Interval间隔
     */
    var text_date_interval: some View {
        Text(DateInterval(start: .now, duration: 1000))
    }

    var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2021, month: 1, day: 1)
        let endComponents = DateComponents(year: 2024, month: 1, day: 1)
        return calendar.date(from: startComponents)! ... calendar.date(from: endComponents)!
    }
    var text_date_range: some View {
        Text(dateRange)
    }

    /*
     Text.DateStyle

     static let date: Text.DateStyle
     static let time: Text.DateStyle

     static let timer: Text.DateStyle
     A style displaying a date as timer counting from now.即以当前为时间，开始一个计时器

     static let offset: Text.DateStyle
     A style displaying a date as offset from now. 即以当前为时间，同样开启一个计时器，只是显示方式不一样

     static let relative: Text.DateStyle
     A style displaying a date as relative to now. 即以当前为时间，同样开启一个计时器，只是显示方式不一样
     */
    var text_date_style: some View {
        VStack {
            Text(Date.now, style: .date)
            Text(Date.now, style: .time)

            Text(Date.now, style: .timer)
            Text(Date.now, style: .offset)
            Text(Date.now, style: .relative)
        }
    }
}

// MARK: - Creating text with formatting
extension TextTutorial {

    /*
     FormateStyle协议。
     ByteCountFormatStyle
     ByteCountFormatStyle.Attributed
     Date.AttributedStyle
     Date.ComponentsFormatStyle
     Date.FormatStyle
     Date.ISO8601FormatStyle
     Date.IntervalFormatStyle
     Date.RelativeFormatStyle
     Date.VerbatimFormatStyle
     Decimal.FormatStyle
     Decimal.FormatStyle.Attributed
     Decimal.FormatStyle.Currency
     Decimal.FormatStyle.Percent
     Duration.TimeFormatStyle
     Duration.UnitsFormatStyle
     FloatingPointFormatStyle
     FloatingPointFormatStyle.Attributed
     FloatingPointFormatStyle.Currency
     FloatingPointFormatStyle.Percent
     IntegerFormatStyle
     IntegerFormatStyle.Attributed
     IntegerFormatStyle.Currency
     IntegerFormatStyle.Percent
     ListFormatStyle
     Measurement.AttributedStyle
     Measurement.AttributedStyle.ByteCount
     Measurement.FormatStyle
     Measurement.FormatStyle.ByteCount
     Conforms when UnitType is UnitInformationStorage.
     PersonNameComponents.AttributedStyle
     PersonNameComponents.FormatStyle
     Product.SubscriptionPeriod.Unit.FormatStyle
     StringStyle
     URL.FormatStyle

     init(_:formatter:)初始化器的Subject类型参数必须是ReferenceConvertible的，这意味着传递给该初始化器的对象必须能够转换为一个Foundation框架中的类。这通常适用于Foundation框架中定义的类型，如Date、NSNumber等。
     */
    var text_formatting: some View {
        VStack {
            // Date的formate
            Text(Date.now, format: Date.FormatStyle(date: .numeric, time: .omitted))
            Text(Date.now, format: Date.FormatStyle(date: .complete, time: .complete))
            Text(Date.now, format: Date.FormatStyle().hour().minute())


            Text(Date.now, format: Date.FormatStyle.dateTime.day().month().year())
            Text(0.235, format: .number.precision(.fractionLength(2)))
        }
    }
}

// MARK: - Creating text from a iamge
extension TextTutorial {

    var text_image: some View {
        Text(Image(systemName: "pencil.tip")) + Text("Image")
    }
}

// MARK: - Choosing font
extension TextTutorial {

    /*
     需要传递Font

     Font.Weight字重

     Font.Design字样式
     case monospaced
     case rounded
     case serif

     Font.Width字宽
     static let compressed: Font.Width
     static let condensed: Font.Width
     static let expanded: Font.Width
     static let standard: Font.Width
     */
    var text_font: some View {

        VStack(content: {
            Text("title")
                .font(.title)

            Text("system")
                .font(.system(size: 14))

            Text("FontWeight")
                .font(.body)
                .fontWeight(.bold)

            Text("FontDesign")
                .font(.body)
                .fontDesign(.serif)

            Text("FontWidth")
                .font(.body)
                .fontWidth(.expanded)
        })

    }
}

// MARK: - styling the view text
extension TextTutorial {

    var text_style: some View {
        VStack {
            Text("Bold")
                .bold()

            Text("ForegroundStyle")
                .foregroundStyle(.red)

            Text("Italic")
                .italic()

            Text("Strikethrough")
                .strikethrough(color: .red)
            Text("Strikethrough")
                .strikethrough(pattern: .dashDotDot, color: .red)

            Text("Underline")
                .underline(color: .red)

            // Text视图的.monospaced()修饰符用于将文本视图中的文字设置为等宽（或称为单间距）字体样式。等宽字体是指所有字符（包括空格）占用相同的水平空间。这种字体风格通常用于代码显示、表格数据或任何需要对齐的场景，以确保文本的一致对齐和可读性。
            Text("Monospaced")
                .monospaced(true)
            Text("MonospacedDigit 20240123")
                .monospacedDigit()

            // 字距调整
            Text("Kerning")
                .kerning(2)
                .background(Color.red)

            Text("Tracking")
                .tracking(2)
                .background(Color.red)
        }
    }
}

#Preview {
    TextTutorial()
}
