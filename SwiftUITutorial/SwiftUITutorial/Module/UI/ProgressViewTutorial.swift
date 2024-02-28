//
//  ProgressViewTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/20.
//

import SwiftUI

/*
 ProgressView正常初始化很好理解，有一个重要的初始化方法
 init(timerInterval:countsDown:)
 init(timerInterval:countsDown:label:currentValueLabel:)
 这里面会引入一个重要的结构体：DefaultDateProgressLabel，当timeInterval没有currentValueLabel适合，会用该结构体。


 ProgressViewStyle一个协议：
 CircularProgressViewStyle // 在不同平台上表现的还不一样，特别是macOS上面。
 DefaultProgressViewStyle
 LinearProgressViewStyle
 */
struct ProgressViewTutorial: View {

    @State private var value = 10.0

    private let start = Date()
    private let end = Date().addingTimeInterval(20)

    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {
            ProgressView()
                .frame(width: 50, height: 50)
                .border(.red)
            ProgressView("ProgressView")
                .border(.red)
                .controlSize(.extraLarge)


            ProgressView {
                Label("ProgressView", systemImage: "eraser")
            }
            Divider()

            ProgressView("Progress Value", value: value, total: 100)
                .padding()
                .border(.pink, width: 1)

            ProgressView(value: value) {
                Text("ProgressView")
            } currentValueLabel: {
                Text("currentValueLabel\(value)")
            }
            .padding()
            .border(.green)

            VStack {
                ProgressView(timerInterval: start...end, countsDown: true)
                ProgressView(timerInterval: start...end, countsDown: false)
            }.padding().border(.indigo)

        }
        .padding()
    }
}

#Preview {
    ProgressViewTutorial()
}
