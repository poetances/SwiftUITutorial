//
//  PaddingTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/28.
//

import SwiftUI

/*
 主要关注其初始化：
 func padding(_ length: CGFloat) -> some View
 func padding(
     _ edges: Edge.Set = .all,
     _ length: CGFloat? = nil
 ) -> some View
 func padding(_ insets: EdgeInsets) -> some View

 注意是OptionSet类型
 struct Edge.Set: OpetionSet
 static let all: Edge.Set
 static let top: Edge.Set
 static let bottom: Edge.Set
 static let leading: Edge.Set
 static let trailing: Edge.Set
 static let horizontal: Edge.Set
 static let vertical: Edge.Set
 */
struct PaddingTutorial: View {
    var body: some View {
        VStack {
            Text("Text padded by 10 points on each edge.")
                .padding(10)
                .border(.gray)
            Text("Unpadded text for comparison.")
                .padding([.bottom, .trailing], 20)
                .border(.yellow)
        }
    }
}

#Preview {
    PaddingTutorial()
}
