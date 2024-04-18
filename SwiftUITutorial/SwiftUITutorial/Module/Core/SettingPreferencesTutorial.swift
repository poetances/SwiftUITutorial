//
//  SettingPreferencesTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/4/15.
//

import SwiftUI

/*
 func preference<K>(
     key: K.Type = K.self,
     value: K.Value
 ) -> some View where K : PreferenceKey

 func transformPreference<K>(
     _ key: K.Type = K.self,
     _ callback: @escaping (inout K.Value) -> Void
 ) -> some View where K : PreferenceKey

 protocol PreferenceKey
 static var defaultValue: Self.Value
 static func reduce(value: inout Self.Value, nextValue: () -> Self.Value)


 Preference是和Environment相对的，我们知道Environment是从上往下传值，相当于环境变量中注入固定值。而Preference刚好
 相反，是从下往上传值。
 */
struct SettingPreferencesTutorial: View {
    var body: some View {
        List(0 ..< 12) { index in
            Text("\(index)")
                .preference(key: StringValuePreferenceKey.self, value: "\(index)")
        }
        .navigationTitle("SettingPreferences")
        .transformPreference(StringValuePreferenceKey.self) { value in
            value += "|Transform"
        }
        .onPreferenceChange(StringValuePreferenceKey.self) { value in
            print("onPreferenceChange", value)
        }
    }
}

struct StringValuePreferenceKey: PreferenceKey {

    static var defaultValue = ""

    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

#Preview {
    SettingPreferencesTutorial()
}
