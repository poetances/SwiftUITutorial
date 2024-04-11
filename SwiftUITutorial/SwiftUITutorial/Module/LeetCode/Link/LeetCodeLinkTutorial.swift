//
//  LeetCodeLinkTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/3/29.
//

import SwiftUI

struct LeetCodeLinkTutorial: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

class ListNode<E> {
    var val: E
    var next: ListNode?

    init(_ val: E) { self.val = val; self.next = nil; }
    init(_ val: E, _ next: ListNode?) { self.val = val; self.next = next; }
}

extension LeetCodeLinkTutorial {

    /**
     题意：删除链表中等于给定值 val 的所有节点。

     示例 1： 输入：head = [1,2,6,3,4,5,6], val = 6 输出：[1,2,3,4,5]

     示例 2： 输入：head = [], val = 1 输出：[]

     示例 3： 输入：head = [7,7,7,7], val = 7 输出：[]
     */

    /**
     * Definition for singly-linked list.
     * public class ListNode {
     *     public var val: Int
     *     public var next: ListNode?
     *     public init() { self.val = 0; self.next = nil; }
     *     public init(_ val: Int) { self.val = val; self.next = nil; }
     *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
     * }
     */
    func removeElements<E: Comparable>(_ head: ListNode<E>?, _ val: E) -> ListNode<E>? {
        let dummyNode = ListNode(val)
        dummyNode.next = head
        var currentNode = dummyNode
        while let curNext = currentNode.next {
            if curNext.val == val {
                currentNode.next = curNext.next
            } else {
                currentNode = curNext
            }
        }
        return dummyNode.next
    }
}

#Preview {
    LeetCodeLinkTutorial()
}
