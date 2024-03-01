//
//  ConfiguringSpacingTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/3/1.
//

import SwiftUI

/*
 listRowSpacing(_:)
 listSectionSpacing(_:)

 ListSectionSpacing
 static let `default`: ListSectionSpacing
    The default spacing between sections
 static let compact: ListSectionSpacing
    Compact spacing between sections
 static func custom(CGFloat) -> ListSectionSpacing
    Creates a custom spacing value.

 需要理解两个方法的作用
 */
struct ConfiguringSpacingTutorial: View {
    var body: some View {
        List {
            Section("Header") {
                ForEach(0 ..< 10) { index in
                    Text("Item \(index)")
                }
            }

            Section("Header2") {
                ForEach(10 ..< 20) { index in
                    Text("Item \(index)")
                }
            }
        }
        .listStyle(.grouped)
        .listSectionSpacing(40)
        .listRowSpacing(10)
    }
}

#Preview {
    ConfiguringSpacingTutorial()
}
