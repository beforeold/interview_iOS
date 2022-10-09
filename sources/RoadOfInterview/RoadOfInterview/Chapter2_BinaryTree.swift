//
//  Chapter2_BinaryTree.swift
//  RoadOfInterview
//
//  Created by beforeold on 2022/10/9.
//

import Foundation

/// leetcode 链接
/// 前序遍历：https://leetcode.cn/problems/binary-tree-preorder-traversal/
/// 中序遍历：https://leetcode.cn/problems/binary-tree-inorder-traversal/
/// 后序遍历：https://leetcode.cn/problems/binary-tree-postorder-traversal/
public class TreeNode {
  public var val: Int
  public var left: TreeNode?
  public var right: TreeNode?
  public init(_ val: Int) {
    self.val = val
  }
}

func maxDepth(_ root: TreeNode?) -> Int {
  guard let root = root else {
    return 0
  }
  
  return max(maxDepth(root.left), maxDepth(root.right)) + 1
}

/// is valid binary search tree
func isValidBST(_ root: TreeNode?) -> Bool {
  return _isValidBSTNode(root, min: nil, max: nil)
}

func _isValidBSTNode(_ node: TreeNode?, min: Int?, max: Int?) -> Bool {
  guard let node = node else {
    return true
  }
  
  if let min = min, node.val <= min {
    return false
  }
  
  if let max = max, node.val >= max {
    return false
  }
  
  return _isValidBSTNode(node.left, min: min, max: node.val)
  && _isValidBSTNode(node.right, min: node.val, max: max)
}

/// 思路：先根结点，再右左都入栈
func preorderTraversal(_ root: TreeNode?) -> [Int] {
  guard let root = root else {
    return []
  }
  
  var ret = [Int]()
  var stack = [TreeNode]()
  stack.append(root)
  
  while !stack.isEmpty {
    let popped = stack.removeLast()
    ret.append(popped.val)
    
    if let right = popped.right {
      stack.append(right)
    }
    
    if let left = popped.left {
      stack.append(left)
    }
  }
  
  return ret
}

/// 先到最左边，保存右边的结点
/// 参考 MJ 实现
func preorderTraversal2(_ root: TreeNode?) -> [Int] {
  var node = root
  var ret = [Int]()
  var stack = [TreeNode]()
  
  while true {
    if node != nil {
      ret.append(node!.val)
      if let right = node?.right {
        stack.append(right)
      }
      node = node?.left
    } else if stack.count > 0 {
      node = stack.removeLast()
    } else {
      break
    }
  }
  
  return ret
}

/// 先左结点都入队，否则从右边开始
/// 优化：参考《iOS 面试之道》实现
func preorderTraversal3_recommend(_ root: TreeNode?) -> [Int] {
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

/// 先左结点都入队，否则从右边开始
/// 参考《iOS 面试之道》实现
func preorderTraversal4(_ root: TreeNode?) -> [Int] {
  var node = root
  var ret = [Int]()
  var stack = [TreeNode]()
  
  while node != nil || stack.count > 0 {
    if node != nil {
      ret.append(node!.val)
      stack.append(node!)
      node = node?.left
    } else {
      let popped = stack.removeLast()
      node = popped.right
    }
  }
  
  return ret
}

/// 先找到最左的结点，依次保存，然后开始使用
/// 参考 MJ 实现
func inorderTraversal(_ root: TreeNode?) -> [Int] {
  var node = root
  var ret = [Int]()
  var stack = [TreeNode]()
  
  while true {
    if node != nil {
      stack.append(node!)
      node = node?.left
    } else if stack.count > 0 {
      let popped = stack.removeLast()
      ret.append(popped.val)
      node = popped.right
    } else {
      break
    }
  }
  
  return ret
}

/// 先保存所有的左节点，然后开始使用
/// 参考 《iOS 面试之道》的前序遍历实现
func inorderTraversal2(_ root: TreeNode?) -> [Int] {
  var node = root
  var ret = [Int]()
  var stack = [TreeNode]()
  
  while node != nil || stack.count > 0 {
    if node != nil {
      stack.append(node!)
      node = node?.left
    } else {
      let popped = stack.removeLast()
      ret.append(popped.val)
      node = popped.right
    }
  }
  
  return ret
}

/// 先一直到最左，然后 pop 处理
/// 基本等同于 inorderTraversal2
func inorderTraversal3_recommend(_ root: TreeNode?) -> [Int] {
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


/// 后序遍历，通过反转前序遍历进行实现
func postOrderTraversal(_ root: TreeNode?) -> [Int] {
  guard let root = root else {
    return []
  }
  
  var stack = [TreeNode]()
  var ret = [Int]()
  stack.append(root)
  
  while stack.count > 0 {
    let popped = stack.removeLast()
    ret.append(popped.val)
    
    if let left = popped.left {
      stack.append(left)
    }
    
    if let right = popped.right {
      stack.append(right)
    }
  }
  
  return ret.reversed()
}

/// 后序遍历，一直向左，并沿路保存，最后逐个 pop
/// 参考 MJ 实现
func postOrderTraversal2(_ root: TreeNode?) -> [Int] {
  func isLeaf(_ node: TreeNode) -> Bool {
    return node.left == nil && node.right == nil
  }
  
  func isParent(_ node: TreeNode, prevPopped: TreeNode?) -> Bool {
    guard let prevPopped = prevPopped else {
      return false
    }
    return node.left === prevPopped || node.right === prevPopped
  }
  
  guard let root = root else {
    return []
  }
  
  var prevPopped: TreeNode?
  var stack = [TreeNode]()
  var ret = [Int]()
  stack.append(root)
  
  while stack.count > 0 {
    let peek = stack.last!
    if isLeaf(peek) || isParent(peek, prevPopped: prevPopped) {
      let popped = stack.removeLast()
      ret.append(popped.val)
      prevPopped = popped
      
    } else {
      if let right = peek.right {
        stack.append(right)
      }
      if let left = peek.left {
        stack.append(left)
      }
    }
  }
  
  return ret
}

/// 后序遍历，先找到最左边，再尝试 pop 或者切换到右子树
/// 参考 LeetCode 官方实现
func postOrderTraversal3_recommend(_ root: TreeNode?) -> [Int] {
  var ret = [Int]()
  var stack = [TreeNode]()
  var node = root
  var prevPopped: TreeNode? = nil
  
  while (node != nil || !stack.isEmpty) {
    while node != nil {
      stack.append(node!)
      node = node?.left
    }
    
    let popped = stack.removeLast()
    if popped.right == nil || popped.right === prevPopped {
      ret.append(popped.val)
      prevPopped = popped
      // 清空重新进入循环
      node = nil
    } else {
      // 重新入栈，并处理右子树
      stack.append(popped)
      node = popped.right
    }
  }
  
  return ret
}


func levelTraversal(_ root: TreeNode?) -> [Int] {
  guard let root = root else {
    return []
  }
  
  var ret = [Int]()
  var queue = [TreeNode]()
  queue.append(root)
  
  while !queue.isEmpty {
    let dequeue = queue.removeFirst()
    ret.append(dequeue.val)
    if let left = dequeue.left {
      queue.append(left)
    }
    
    if let right = dequeue.right {
      queue.append(right)
    }
  }
  
  return ret
}

func levelTraversal2(_ root: TreeNode?) -> [[Int]] {
  var ret = [[Int]]()
  var queue = [TreeNode]()
  
  if let root = root {
    queue.append(root)
  }
  
  while queue.count > 0 {
    let size = queue.count
    var level = [Int]()
    
    for _ in 0..<size {
      let dequeue = queue.removeFirst()
      level.append(dequeue.val)
      
      if let left = dequeue.left {
        queue.append(left)
      }
      
      if let right = dequeue.right {
        queue.append(right)
      }
    }
    
    ret.append(level)
  }
  
  return ret
}

typealias TreeNodeValue = (Int, Int?, Int?)
func levelTraversal3(_ root: TreeNode?) -> [[TreeNodeValue]] {
  var ret = [[TreeNodeValue]]()
  var queue = [TreeNode]()
  
  if let root = root {
    queue.append(root)
  }
  
  while queue.count > 0 {
    let size = queue.count
    var level = [TreeNodeValue]()
    
    for _ in 0..<size {
      let dequeue = queue.removeFirst()
      level.append((dequeue.val, dequeue.left?.val, dequeue.right?.val))
      
      if let left = dequeue.left {
        queue.append(left)
      }
      
      if let right = dequeue.right {
        queue.append(right)
      }
    }
    
    ret.append(level)
  }
  
  return ret
}
