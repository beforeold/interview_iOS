//
//  BinaryTreeDemo.swift
//  RoadOfInterview
//
//  Created by beforeold on 2022/10/9.
//

import Foundation

struct BinaryTreeDemo {
  func preorderTraversal(_ root: TreeNode?) -> [Int] {
    var ret = [Int]()
    var stack = [TreeNode]()
    var node = root
    
    while node != nil || stack.count > 0 {
      while node != nil {
        ret.append(node!.val)
        stack.append(node!)
        node = node?.left
      }
      
      let popped = stack.removeLast()
      node = popped.right
    }
    
    return ret
  }
  
  func inorderTraversal(_ root: TreeNode?) -> [Int] {
    var ret = [Int]()
    var stack = [TreeNode]()
    var node = root
    
    while node != nil || stack.count > 0 {
      while node != nil {
        stack.append(node!)
        node = node?.left
      }
      
      let popped = stack.removeLast()
      ret.append(popped.val)
      node = popped.right
    }
    
    return ret
  }
  
  func postorderTraversal(_ root: TreeNode?) -> [Int] {
    var ret = [Int]()
    var stack = [TreeNode]()
    var node = root
    var prevPopped: TreeNode?
    
    while node != nil || stack.count > 0 {
      while node != nil {
        stack.append(node!)
        node = node?.left
      }
      
      let popped = stack.removeLast()
      if popped.right == nil || popped.right === prevPopped {
        ret.append(popped.val)
        prevPopped = popped
        node = nil
        
      } else {
        stack.append(popped)
        node = popped.right
      }
    }
    
    return ret
  }
  
  func levelOrderTraversal(_ root: TreeNode?) -> [[Int]] {
    guard let root = root else {
      return []
    }
    
    var ret = [[Int]]()
    var queue = [TreeNode]()
    queue.append(root)
    
    while queue.count > 0 {
      var level = [Int]()
      
      for _ in 0..<queue.count {
        let dequeued = queue.removeFirst()
        level.append(dequeued.val)
        
        if let left = dequeued.left {
          queue.append(left)
        }
        
        if let right = dequeued.right {
          queue.append(right)
        }
      }
      
      ret.append(level)
    }
    
    return ret
  }
}

extension BinaryTreeDemo {
  class _day_20221020_ {
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
      var ret = [Int]()
      var stack = [TreeNode]()
      var node = root
      
      while node != nil || stack.count > 0 {
        while node != nil {
          stack.append(node!)
          node = node?.left
        }
        
        let popped = stack.removeLast()
        ret.append(popped.val)
        node = popped.right
      }
      
      return ret
    }
    
    func inorderTraversal_right_middle_left(_ root: TreeNode?) -> [Int] {
      var ret = [Int]()
      var stack = [TreeNode]()
      var node = root
      
      while node != nil || stack.count > 0 {
        while node != nil {
          stack.append(node!)
          node = node?.right
        }
        
        let popped = stack.removeLast()
        ret.append(popped.val)
        node = popped.left
      }
      
      return ret
    }
  }
}

extension BinaryTreeDemo._day_20221020_ {
  // 面试题54. 二叉搜索树的第 k 大节点（中序遍历 + 提前返回，清晰图解）
  // https://leetcode.cn/problems/er-cha-sou-suo-shu-de-di-kda-jie-dian-lcof/solution/mian-shi-ti-54-er-cha-sou-suo-shu-de-di-k-da-jie-d/
  
  class Solution {
      func kthLargest(_ root: TreeNode?, _ k: Int) -> Int {
        var count = 0
        var stack = [TreeNode]()
        var node = root
        
        while node != nil || stack.count > 0 {
          while node != nil {
            stack.append(node!)
            node = node?.right
          }
          
          let popped = stack.removeLast()
          count += 1
          
          if count == k {
            return popped.val
          }
          
          node = popped.left
        }
        
        fatalError()
      }
  }
  
  
  // https://leetcode.cn/problems/merge-two-sorted-lists/
  func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
    let dummy = ListNode(0)
    var curNode: ListNode? = dummy
    
    var list1 = list1
    var list2 = list2
    
    while list1 != nil || list2 != nil {
      if list1!.val < list2!.val {
        curNode?.next = list1
        list1 = list1?.next
      } else {
        curNode?.next = list2
        list2 = list2?.next
      }
      curNode = curNode?.next
    }
    
    curNode = list1 ?? list2
    
    return dummy.next
  }
}
