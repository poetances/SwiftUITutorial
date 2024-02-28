//
//  LayoutsFundamentalsPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/25.
//

import SwiftUI

/*
 基本的结构体：
 HStack、VStack
 LazyHStack、LazyVStack、PinnedScrollableViews
 */
struct LayoutsFundamentalsPage: View {

    private let sections = [
        ColorData(color: .red, name: "Reds"),
        ColorData(color: .green, name: "Greens"),
        ColorData(color: .blue, name: "Blues")
    ]

    @State private var isOn = false

    @State private var name = ""

    // MARK: - system
    var body: some View {
        //hstack
        //vstack
        //lazy_hstack
        //lazy_vstack
        //grid
        //lazy_grid
        //zstack
        //view_that_fits
        sapcer_divider
    }
}

// MARK: - HStack、VStack
extension LayoutsFundamentalsPage {
    
    var hstack: some View {
        HStack(
                alignment: .top,
                spacing: 10
            ) {
                ForEach(
                    1...5,
                    id: \.self
                ) {
                    Text("Item \($0)")
                    Divider()
                }
            }
    }

    var vstack: some View {
        VStack(
                alignment: .leading,
                spacing: 10
            ) {
                ForEach(
                    1...5,
                    id: \.self
                ) {
                    Text("Item \($0)")
                    Divider()
                }
            }
    }
}

// MARK: - LazyHStak & LazyVStack
extension LayoutsFundamentalsPage {
    /*
     LazyHStack & LazyVStack
     超出屏幕不显示，这是和HStack VStack的根本区别。一般配合ScrollView
     使用，类似List，但是不同的是List会自动增加分割线，同时会有相应的样式。

     PinnedScrollableViews
     如果里面有Section，可以通过pinnedViews来指定section的样式是否pinned
     */
    var lazy_hstack: some View {
        ScrollView(.horizontal) {
            LazyHStack(content: {
                ForEach(1...10, id: \.self) { count in
                    Text("Placeholder \(count)")
                }
            })
        }
    }

    var lazy_vstack: some View {
        ScrollView {
            LazyVStack(pinnedViews: [.sectionHeaders], content: {
                ForEach(sections) { section in
                    Section(section.name) {
                        ForEach(section.variations) { varation in
                            section.color
                                .brightness(varation.brightness)
                                .frame(height: 46)
                        }
                    }
                }
            })
        }
    }

    struct ColorData: Identifiable {
        let id = UUID()
        let name: String
        let color: Color
        let variations: [ShadeDate]

        init(color: Color, name: String) {
            self.name = name
            self.color = color
            self.variations = stride(from: 0.0, to: 0.5, by: 0.1).map { ShadeDate(brightness: $0) }
        }

        struct ShadeDate: Identifiable {
            let id = UUID()
            let brightness: Double
        }
    }
}

// MARK: - Grid
extension LayoutsFundamentalsPage {

    /*
     A container view that arranges other views in a two dimensional layout.

     二维容器，类似九宫格。方法很简单，主要有几个方法需要注意：
     gridCellColumns(_:) // 横跨宽度
     gridCellAnchor(_:)  // 对齐的锚点位置
     gridCellUnsizedAxes(_:) // 拉伸模式
     gridColumnAlignment(_:) // 覆盖对齐方式
     这些方法都是修饰Grid里面的cell。
     */
    var grid: some View {
        ScrollView {
            LazyVStack {
                Grid(horizontalSpacing: 2.0, verticalSpacing: 2.0) {
                    ForEach(0..<5) { x in
                        GridRow(alignment: .center) {
                            ForEach(0..<5) { y in
                                Text("(\(x),\(y))")
                                    .padding()
                                    .border(.pink)
                            }
                        }
                    }
                }
                .border(.red)

                Grid {
                    GridRow {
                        Text("Hello")
                        Image(systemName: "globe")
                    }
                    Divider()
                        .gridCellUnsizedAxes(.horizontal)
                    GridRow {
                        Image(systemName: "hand.wave")
                        Text("World")
                    }
                }
                .border(.yellow)

                Grid(alignment: .leadingFirstTextBaseline) {
                    GridRow {
                        Text("Regular font:")
                            .gridColumnAlignment(.trailing)
                        Text("Helvetica 12")
                        Button("Select...") { }
                    }
                    GridRow {
                        Text("Fixed-width font:")
                        Text("Menlo Regular 11")
                        Button("Select...") { }
                    }
                    GridRow {
                        Color.clear
                            .gridCellUnsizedAxes([.vertical, .horizontal])
                        Toggle("Use fixed-width font for new documents", isOn: $isOn)
                            .gridCellColumns(2) // Span two columns.
                    }
                }

                Grid(alignment: .center, horizontalSpacing: 1, verticalSpacing: 1) {
                    GridRow {
                        Color.red.frame(width: 60, height: 60)
                        Color.red.frame(width: 60, height: 60)
                        Color.red.frame(width: 60, height: 60)
                    }
                    GridRow {
                        Color.red.frame(width: 60, height: 60)
                        Color.blue.frame(width: 10, height: 10)
                            .gridCellColumns(2)
                            .gridCellAnchor(.init(x: 0.2, y: 0.2))
                    }
                }
            }
        }
    }
}

// MARK: - LazyHGrid & LazyHGrid
extension LayoutsFundamentalsPage {

    /*
     LazyHGrid LazyVGrid都会涉及到一个结构体GridItem。
     很好理解LazyHGrid、LazyVGrid一般在超出屏幕的时候使用，而能超出屏幕就说明钱空间是无线的，所以必须依赖GridItem来指定数量
     Use a lazy horizontal grid when you want to display a large, horizontally scrollable collection of views arranged in a two dimensional layout. The first view that you provide to the grid’s content closure appears in the top row of the column that’s on the grid’s leading edge. Additional views occupy successive cells in the grid, filling the first column from top to bottom, then the second column, and so on. The number of columns can grow unbounded, but you specify the number of rows by providing a corresponding number of GridItem instances to the grid’s initializer.

     上面解释就是，如果想要二维屏幕，使用LazyHGrid、LazyVGrid。注意使用技巧：
     rows表示行

     GridItem中
     space: The spacing to the next item.
     size: The size of the item, which is the width of a column item or the height of a row item.
     */
    var lazy_grid: some View {
        ScrollView {
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.fixed(30)), GridItem(.fixed(30))], content: {
                    ForEach(0x1f600...0x1f679, id: \.self) { value in
                        Text(String(format: "%x", value))
                        Text(emoji(value))
                            .font(.largeTitle)
                    }
                })
            }

            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, content: {
                    ForEach(0...300, id: \.self) { _ in
                        Color.red.frame(width: 30)
                        Color.green.frame(width: 30)
                        Color.blue.frame(width: 30)
                        Color.yellow.frame(width: 30)
                    }
                })
                .border(.red)
            }
        }
    }

    var rows: [GridItem] {
        [
            GridItem(.fixed(30), spacing: 1),
            GridItem(.fixed(60), spacing: 10),
            GridItem(.fixed(90), spacing: 20),
            GridItem(.fixed(10), spacing: 50)
        ]
    }
    private func emoji(_ value: Int) -> String {
        guard let scalar = UnicodeScalar(value) else { return "?" }
        return String(Character(scalar))
    }
}

// MARK: - ZStack & background & overlay
extension LayoutsFundamentalsPage {

    /*
     如果只是一个背景，我们应该优先考虑background、overlazy
     只有复杂情况才会考虑ZStack

     zIndex(_:) zIndex不仅适用于ZStack，像其它HStack、VStack都适用。
     background(alignment:content:)
     overlay(_:in:fillStyle:)
     */
    var zstack: some View {
        ZStack {
            LinearGradient(
                colors: [Color.red, Color.blue],
                startPoint: .top, endPoint: .bottom)

            VStack {
                Text("Welcome")
                    .font(.title)
                HStack {
                    TextField("Your name?", text: $name)
                        .textFieldStyle(.roundedBorder)
                    Button(action: {}, label: {
                        Image(systemName: "arrow.right.square")
                            .font(.title)
                    })
                }
                .padding()
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - ViewThatFits
extension LayoutsFundamentalsPage {

    /*
     ViewThatFits 通常包含两个或更多的视图，它会尝试按顺序放置这些视图。SwiftUI会尝试从第一个视图开始，检查它是否能够在给定的布局约束中适应。如果第一个视图无法适应，则尝试下一个视图，依此类推。最终，ViewThatFits 会选择第一个能够适应布局约束的视图进行显示。如果所有的视图都无法适应，它将不显示任何视图。
     */
    struct UploadProgressView: View {
        var uploadProgress: Double

        var body: some View {
            ViewThatFits(in: .horizontal) {
                HStack {
                    Text("\(uploadProgress.formatted(.percent))")
                    ProgressView(value: uploadProgress)
                        .frame(width: 100)
                }
                ProgressView(value: uploadProgress)
                    .frame(width: 100)
                Text("\(uploadProgress.formatted(.percent))")
            }
        }
    }

    var view_that_fits: some View {
        VStack {
            UploadProgressView(uploadProgress: 0.75)
                    .frame(maxWidth: 200)
            UploadProgressView(uploadProgress: 0.75)
                    .frame(maxWidth: 100)
            UploadProgressView(uploadProgress: 0.75)
                    .frame(maxWidth: 50)
        }
    }
}

// MARK: - Spacer & Divider
extension LayoutsFundamentalsPage {

    var sapcer_divider: some View {
        HStack {
            Spacer()
            Divider()
            Text("SpacerAndDivider")
        }
    }
}

#Preview {
    LayoutsFundamentalsPage()
}
