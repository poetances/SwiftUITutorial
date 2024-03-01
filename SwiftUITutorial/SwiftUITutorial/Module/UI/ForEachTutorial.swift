//
//  ForEachTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/3/1.
//

import SwiftUI

/*
 struct ForEach<Data, ID, Content> where Data : RandomAccessCollection, ID : Hashable

 Use ForEach to provide views based on a RandomAccessCollection of some data type. Either the collection’s elements must conform to Identifiable or you need to provide an id parameter to the ForEach initializer.
 详细说明了ForEach的两种使用方式。

 其实ForEach的初始化和List很像，我们发现List的初始化，其中content大部分都是ForEach类型，我们可以理解为List是ScrollView + ForEach

 ForEach遵循一个协议：
 DynamicViewContent
 func onDelete(perform: Optional<(IndexSet) -> Void>) -> some DynamicViewContent
    Sets the deletion action for the dynamic view.
 func onInsert(of: [UTType], perform: (Int, [NSItemProvider]) -> Void) -> some DynamicViewContent
    Sets the insert action for the dynamic view.
 func onMove(perform: Optional<(IndexSet, Int) -> Void>) -> some DynamicViewContent
    Sets the move action for the dynamic view.
 func dropDestination<T>(for: T.Type, action: ([T], Int) -> Void) -> some DynamicViewContent
    Sets the insert action for the dynamic view.
 这也是解释了为什么List里面可以进行onMove、onDetelete、OnInsert
 */
struct ForEachTutorial: View {
    var body: some View {
        ForEach(0 ..< 5) { index in
            Text("Item \(index)")
        }
        .onMove(perform: { indices, newOffset in
            print(indices, newOffset)
        })
    }
}

#Preview {
    ForEachTutorial()
}
