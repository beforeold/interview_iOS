//
//  iOSDemo.swift
//  RoadOfInterview
//
//  Created by beforeold on 2022/10/16.
//

import UIKit

// 查找两个视图的最近公共父视图
// 类似于查找两个链表的相交结点
// https://leetcode.cn/problems/intersection-of-two-linked-lists/

struct iOSDemo {
  static func closestommonSuperView(_ v1: UIView, _ v2: UIView) -> UIView? {
    var ret: UIView?
    var second: UIView? = v2
    
    while (ret != nil && second != nil) {
      var first: UIView? = v1
      while (ret != nil && first != nil) {
        if first === second {
          ret = first
        } else {
          first = first?.superview
        }
      }
      second = second?.superview
    }
    
    return ret
  }
  
  func _2_closestommonSuperView(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
    if headA == nil || headB == nil {
      return nil
    }
    
    var setA: Set<ListNode> = []
    var node = headA
    while node != nil {
      setA.insert(node!)
      node = node?.nextNode
    }
    
    node = headB
    while node != nil {
      if setA.contains(node!) {
        return node
      }
      node = node?.nextNode
    }
    
    return nil
  }
  
  func _3_closestommonSuperView(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
    if headA == nil || headB == nil {
      return nil
    }
    
    var pA = headA
    var pB = headB
    while pA !== pB {
      pA = pA == nil ? headB : pA?.nextNode
      pB = pB == nil ? headA : pB?.nextNode
    }
    return pA
  }
}


extension iOSDemo {
  typealias ListNode = UIView
}

extension iOSDemo.ListNode {
  var nextNode: iOSDemo.ListNode? {
    return self.superview
  }
}


extension iOSDemo {
  func levelTranversal(view: UIView) -> [[UIView]] {
    var ret = [[UIView]]()
    var queue = [UIView]()
    queue.append(view)
    
    while queue.count > 0 {
      let levelSize = queue.count
      var level = [UIView]()
      for _ in 0..<levelSize {
        let dequeued = queue.removeFirst()
        level.append(dequeued)
        queue.append(contentsOf: dequeued.subviews)
      }
      ret.append(level)
    }
    
    return ret
  }
}

extension iOSDemo {
  func findViewOf<T: UIView>(type: T.Type,
                       in view: UIView) -> [T] {
    var ret = [T]()
    
    if let view = view as? T {
      ret.append(view)
    }
    
    let sub = view.subviews.reduce([T]()) { partialResult, view in
      return partialResult + findViewOf(type: type, in: view)
    }
    ret += sub
    
    return ret
  }
}
