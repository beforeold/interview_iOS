//
//  ListDemo2.swift
//  RoadOfInterview
//
//  Created by beforeold on 2022/10/30.
//

import Foundation

struct ListDemo2 {
  func reverseArray(_ array: [Int]) -> [Int] {
    var array = array
    
    var begin = 0
    var end = array.count - 1
    while begin < end {
      array.swapAt(begin, end)
      
      begin += 1
      end -= 1
    }
    
    return array
  }
  
  func reverseLinkedList(_ root: ListNode?) -> ListNode? {
    // 注意临界条件
    if root?.next == nil {
      return root
    }
    
    // 逐个构建新的链表
    var head = root
    var newHead: ListNode? = nil
    
    while head != nil {
      let nextNode = head?.next
      head?.next = newHead
      newHead = head
      head = nextNode
    }
    
    return newHead
  }
  
  func reverseLinkedList_recursion(_ head: ListNode?) -> ListNode? {
    if head?.next == nil {
      return head
    }
    
    let subHead = reverseLinkedList_recursion(head?.next)
    let tail = head?.next
    tail?.next = head
    head?.next = nil
    
    return subHead
  }
}
