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
        stack.append(node!)
        ret.append(node!.val)
        node = node?.left
      }
      
      let popped = stack.removeLast()
      node = popped.right
    }
    
    return ret
  }
}
