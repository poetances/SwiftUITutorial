//
//  PreferencesGeometryTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/4/15.
//

import SwiftUI

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
 */
struct PreferencesGeometryTutorial: View {

    @State private var text = ""
    // MARK: - system
    var body: some View {
        VStack {
            Button("Anchor") {

            }
            .anchorPreference(key: AnchorPreferencesKey.self, value: .bottom) { $0 }

            ZStack {
                TextEditor(text: $text)
                    .textEditorStyle(.plain)
                    .frame(width: 300, height: 250)
                    .background(Color.pink)
                    .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { $0 }
            }
            .backgroundPreferenceValue(BoundsPreferenceKey.self) { bounds in
                GeometryReader(content: { geometry in
                    bounds.map {
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
            }
            .overlayPreferenceValue(StringValuePreferenceKey.self) { value in

            }
        }
        .onPreferenceChange(AnchorPreferencesKey.self) { value in
            print("AnchorPreferencesKey", value ?? "null")
        }
    }
}

struct AnchorPreferencesKey: PreferenceKey {

    static var defaultValue: Anchor<CGPoint>?

    static func reduce(value: inout Anchor<CGPoint>?, nextValue: () -> Anchor<CGPoint>?) {
        value = nextValue()
    }
}

struct BoundsPreferenceKey: PreferenceKey {

    static var defaultValue: Anchor<CGRect>? = nil
    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = nextValue()
    }
}

#Preview {
    PreferencesGeometryTutorial()
}
