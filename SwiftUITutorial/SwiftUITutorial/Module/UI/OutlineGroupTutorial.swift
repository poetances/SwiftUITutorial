//
//  OutlineGroupTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/3/1.
//

import SwiftUI

/*
 struct OutlineGroup<Data, ID, Parent, Leaf, Subgroup> where Data : RandomAccessCollection, ID : Hashable

 A structure that computes views and disclosure groups on demand from an underlying collection of tree-structured, identified data.
 一种树状结构

 我们发现：
 如果List的初始化中有chirldren，那么其初始换的Content就是OutlineGroup类型：
 @MainActor
 init<Data, RowContent>(
     _ data: Data,
     children: KeyPath<Data.Element, Data?>,
     @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent
 ) where Content == OutlineGroup<Data, Data.Element.ID, RowContent, RowContent, DisclosureGroup<RowContent, OutlineSubgroupChildren>>, Data : RandomAccessCollection, RowContent : View, Data.Element : Identifiable
 */
struct OutlineGroupTutorial: View {

    private let data =
    FileItem(
        name: "users",
        children:
            [FileItem(name: "user1234", children:
                        [FileItem(name: "Photos", children:
                                    [FileItem(name: "photo001.jpg"),
                                     FileItem(name: "photo002.jpg")]),
                         FileItem(name: "Movies", children:
                                    [FileItem(name: "movie001.mp4")]),
                         FileItem(name: "Documents", children: [])
                        ]),
             FileItem(name: "newuser", children:
                        [FileItem(name: "Documents", children: [])
                        ])
            ]
    )
    // MARK: - system
    var body: some View {

        OutlineGroup(data, children: \.children) { item in
            Text("\(item.description)")
        }
        .border(.red)
    }

    struct FileItem: Hashable, Identifiable, CustomStringConvertible {
        var id: Self { self }
        var name: String
        var children: [FileItem]? = nil
        var description: String {
            switch children {
            case nil:
                return "📄 \(name)"
            case .some(let children):
                return children.isEmpty ? "📂 \(name)" : "📁 \(name)"
            }
        }
    }
}

#Preview {
    OutlineGroupTutorial()
}
