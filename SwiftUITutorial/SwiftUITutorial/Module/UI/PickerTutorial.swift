//
//  PickerTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2023/12/4.
//

import SwiftUI

/*
 Picker初始化方法比较简单，没什么特殊说明的。
 titleKey
 不會顯示，可用於 accessibility 說明元件的目的，比方搭配 VoiceOver 功能。

 selection
 Picker 綁定的資料。當使用者選取某個項目時，它將更新我們傳入的 selection 參數，因此我們可從 selection 參數判斷使用者選取的項目。

 content
 產生 picker 的選項。

 需要注意的是PickerStyle协议，能够修改Picker的样式。
 DefaultPickerStyle
 InlinePickerStyle
 MenuPickerStyle
 NavigationLinkPickerStyle  用于导航选择
 PalettePickerStyle
 RadioGroupPickerStyle  macos
 SegmentedPickerStyle
 WheelPickerStyle
 */
struct PickerTutorial: View {

    @State private var selection = 0

    @State private var selectedObjectBorders = [
        Border(color: .black, thickness: .thin),
        Border(color: .red, thickness: .thick)
    ]


    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {
            
            Picker("Picker", selection: $selection) {
                Text("One").tag(0)
                Text("Two").tag(1)
            }
            .tint(.red)

            Picker("Board Thickness", sources: $selectedObjectBorders, selection: \.thickness) {
                ForEach(Thickness.allCases) { thickness in
                    Text(thickness.rawValue).tag(thickness)
                }
            }
            .pickerStyle(.wheel)
        }
        .padding()
    }

    enum Thickness: String, CaseIterable, Identifiable {
        case thin
        case regular
        case thick

        var id: String { rawValue }
    }

    struct Border {
        var color: Color
        var thickness: Thickness
    }
}

#Preview {
    PickerTutorial()
}
