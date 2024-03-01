//
//  SafeAreaTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/28.
//

import SwiftUI

/*
 SafeAreaRegions

 SafeArea之间相关联的还有键盘，也就是说，默认情况下，一个textfied
 */
struct SafeAreaTutorial: View {

    @State private var text = ""
    // MARK: - system
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom)
            Circle()
                .fill(Color.pink)
            TextField("", text: $text)
                .textFieldStyle(.roundedBorder)
        }
        .ignoresSafeArea(.container)
    }
}

extension SafeAreaTutorial {

    var safe_area_insert: some View {
        ZStack {
            LinearGradient(
                colors: [Color.red, Color.blue],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .safeAreaPadding(.all)
        .safeAreaInset(edge: VerticalEdge.bottom) {
            Text("Hello, wrold")
        }
    }

    var safe_area_insert2: some View {
        List(0 ..< 40) { id in
            Text("id\(id)")
        }
        .safeAreaInset(edge: .bottom) {
            Image(systemName: "heart")
                .frame(height: 40)
        }
    }

}

#Preview {
    SafeAreaTutorial()
}


struct BoundaryKey: PreferenceKey {

    static var defaultValue = ""

    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}
