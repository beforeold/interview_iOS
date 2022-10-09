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
      node = node?.right
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
        node = node?.right
      }
    }
    
    return ret
  }
}
