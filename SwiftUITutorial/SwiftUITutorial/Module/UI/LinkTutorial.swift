//
//  LinkTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/19.
//

import SwiftUI

struct LinkTutorial: View {
    @Environment(\.openURL) var openUrl

    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {
            Link("百度", destination: URL(string: "https://www.baidu.com")!)
            
            ShareLink(item: URL(string: "https://developer.apple.com/xcode/swiftui/")!)
            ShareLink(item: URL(string: "https://developer.apple.com/xcode/swiftui/")!) {
                Label("Share", image: "MyCustomShareIcon")
            }
        }
    }
}


#Preview {
    LinkTutorial()
}
