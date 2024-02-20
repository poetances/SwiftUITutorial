//
//  DatePickerTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/20.
//

import SwiftUI

/*
 
 DatePicker内置一个结构体：
 DatePickerComponents：里面有三个属性：
 static let date: DatePickerComponents

 static let hourAndMinute: DatePickerComponents

 static let hourMinuteAndSecond: DatePickerComponents // watchos

 DatePickerStyle用户控制样式：
 CompactDatePickerStyle // 默认样式，紧凑的
 DefaultDatePickerStyle
 FieldDatePickerStyle  macos 可编辑输入的
 StepperFieldDatePickerStyle macos
 GraphicalDatePickerStyle // 平面展示的
 WheelDatePickerStyle  // 滑轮的


 MultiDatePicker可以选多个日期
 */

struct DatePickerTutorial: View {

    @Environment(\.calendar) private var calendar
    @Environment(\.timeZone) private var timeZone

    @State private var selection = Date()

    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2021, month: 1, day: 1)
        let endComponents = DateComponents(year: 2024, month: 12, day: 31, hour: 23, minute: 59, second: 59)
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()

    @State private var mSelection: Set<DateComponents> = []
    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {
            DatePicker("DatePicker", selection: $selection)

            DatePicker("DisplayedComponents", selection: $selection, displayedComponents: [.date])
                .background(Color.red)
                .foregroundStyle(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            DatePicker("In", selection: $selection, in: dateRange)
                .datePickerStyle(.graphical)


            MultiDatePicker("MultiDatePicker", selection: $mSelection)
        }
        .padding()
    }
}

#Preview {
    DatePickerTutorial()
}
