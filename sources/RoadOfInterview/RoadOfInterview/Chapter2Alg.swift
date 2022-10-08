//
//  Chapter2Alg.swift
//  RoadOfInterview
//
//  Created by beforeold on 2022/9/25.
//

import Foundation

class Chapter2Alg {
  /// 数组中是否包含两个数之和是目标值
  func twoSum(nums: [Int], targetNum: Int) -> Bool {
    var set = Set<Int>()
    
    for item in nums {
      if set.contains(targetNum - item) {
        return true
      }
      set.insert(item)
    }
    
    return false
  }
  
  /// 数组中有且仅有2个数组之和为目标值，返回两个目标值的 index
  func twoSum(nums: [Int], targetNum: Int) -> [Int] {
    var dict = [Int: Int]()
    
    for (index, item) in nums.enumerated() {
      if let prevIndex = dict[targetNum - item] {
        return [prevIndex, index]
      }
      
      dict[item] = index
    }
    fatalError("invalid input nums \(nums)")
  }
  
  // Page 33
  private func reverse<T>(array: inout [T], start: Int, end: Int) {
    var start = start
    var end = end
    while start < end {
      (array[start], array[end]) = (array[end], array[start])
      start += 1
      end -= 1
    }
  }
  
  func reverseWords(_ string: String?) -> String? {
    guard let string = string else {
      return nil
    }
    
    var chars = string.map { $0 }
    var start = 0
    for i in 0..<chars.count {
      if i == chars.count - 1 || chars[i + 1] == " " {
        reverse(array: &chars, start: start, end: i)
        start = i + 2
      }
    }
    
    return String(chars)
  }
  
  // 链表左右排序：p36
  
  class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int) {
      self.val = val
      self.next = nil
    }
  }
  
  func partion(head: ListNode?, x: Int) -> ListNode? {
    let prevDummy = ListNode(0)
    let postDummy = ListNode(0)
    
    // 注意这两个节点表示当前指向，均不为空
    var prev = prevDummy
    var post = postDummy
    
    var node = head
    
    while node != nil {
      let curNode = node!
      let val = curNode.val
      if val > x {
        prev.next = curNode
        prev = curNode
      } else {
        post.next = curNode
        post = curNode
      }
      node = curNode.next
    }
    
    // 防止 post 链表尾节点指向 prev 链表节点，将其清空
    post.next = nil
    
    // 拼接链表
    prev.next = postDummy.next
    
    return prevDummy.next
  }
  
  func hasCycle(_ head: ListNode?) -> Bool {
    var slow = head
    var fast = head?.next
    
    while fast != nil && fast?.next != nil {
      if slow === fast {
        return true
      }
      
      slow = slow?.next
      fast = fast?.next?.next
    }
    
    return false
  }
  
  func delete(_ head: ListNode?, last n: Int) -> ListNode? {
    let dummy = ListNode(0)
    var prev: ListNode? = dummy
    var post: ListNode? = dummy
    
    // n + 1 times
    for _ in 0..<n {
      post = post?.next
    }
    
    if post == nil {
      // no enough nodes
      return head
    }
    
    // keep post?.next != nil to delete the node
    // for last 3， delete 8，
    //  6 7 8 9 10
    //  . ^ _ . .
    while post != nil {
      prev = prev?.next
      post = post?.next
    }
    
    prev?.next = prev?.next?.next
    
    return dummy.next
  }
}

protocol Stack {
  associatedtype Element
  
  var isEmpty: Bool { get }
  var size: Int { get }
  
  var peek: Element? { mutating get }
  
  mutating func push(_ element: Element)
  
  mutating func pop() -> Element?
}


struct IntegerStack: Stack {
  typealias Element = Int
  private var stack: [Int] = []
  
  
  var isEmpty: Bool {
    return stack.isEmpty
  }
  
  var size: Int {
    return stack.count
  }
  
  var peek: Int? {
    return stack.last
  }
  
  mutating func push(_ element: Int) {
    stack.append(element)
  }
  
  mutating func pop() -> Int? {
    stack.popLast()
  }
}

protocol Queue {
  associatedtype Element
  
  var isEmpty: Bool { get }
  var size: Int { get }
  
  var peek: Element? { mutating get }
  
  mutating func enqueue(_ element: Element)
  
  mutating func dequeue() -> Element?
}

struct IntegerQueue1: Queue {
  typealias Element = Int
  private var queue = [Int]()
  
  var isEmpty: Bool {
    return queue.isEmpty
  }
  
  var size: Int {
    return queue.count
  }
  
  var peek: Int? {
    return queue.first
  }
  
  mutating func enqueue(_ element: Int) {
    queue.append(element)
  }
  
  mutating func dequeue() -> Int? {
    if queue.isEmpty {
      return nil
    }
    return queue.popLast()
  }
}

struct IntegerQueue2: Queue {
  typealias Element = Int
  private var leftOut = [Int]()
  private var rightIn = [Int]()
  
  var isEmpty: Bool {
    return leftOut.isEmpty && rightIn.isEmpty
  }
  
  var size: Int {
    return leftOut.count + rightIn.count
  }
  
  var peek: Int? {
    return leftOut.isEmpty ? rightIn.first : leftOut.last
  }
  
  mutating func enqueue(_ element: Int) {
    rightIn.append(element)
  }
  
  mutating func dequeue() -> Int? {
    shift()
    return leftOut.popLast()
  }
  
  private mutating func shift() {
    if leftOut.isEmpty {
      leftOut = rightIn.reversed()
      rightIn.removeAll()
    }
  }
}

struct MyQueue: Queue {
  typealias Element = Int
  typealias Stack = IntegerStack
  
  var inStackA: Stack
  var outStackB: Stack
  
  var isEmpty: Bool {
    return inStackA.isEmpty && outStackB.isEmpty
  }
  
  var size: Int {
    return inStackA.size + outStackB.size
  }
  
  var peek: Element? {
    mutating get {
      shift()
      return outStackB.peek
    }
  }
  
  mutating func enqueue(_ element: Element) {
    inStackA.push(element)
  }
  
  mutating func dequeue() -> Element? {
    shift()
    return outStackB.pop()
  }
  
  private mutating func shift() {
    guard outStackB.isEmpty else {
      return
    }
    
    while !inStackA.isEmpty {
      if let ins = inStackA.pop() {
        outStackB.push(ins)
      }
    }
  }
}

struct MyStack: Stack {
  typealias Element = Int
  typealias Queue = IntegerQueue2
  
  var queueA: Queue
  var queueB: Queue
  
  var isEmpty: Bool {
    queueA.isEmpty && queueB.isEmpty
  }
  
  var size: Int {
    queueA.size + queueB.size
  }
  
  var peek: Element? {
    mutating get {
      shift()
      return queueA.peek
    }
  }
  
  mutating func push(_ element: Element) {
    queueA.enqueue(element)
  }
  
  mutating func pop() -> Element? {
    shift()
    return queueA.dequeue()
  }
  
  /// 保证 A 不大于 1，同时封装了 swap，确保 A 随时可用
  private mutating func shift() {
    if queueA.size == 0 {
      swap()
    }
    
    while queueA.size > 1 {
      if let ins = queueA.dequeue() {
        queueB.enqueue(ins)
      }
    }
  }
  
  private mutating func swap() {
    (queueA, queueB) = (queueB, queueA)
  }
}

struct MyStack2: Stack {
  typealias Element = Int
  typealias Queue = IntegerQueue2
  
  var queueA: Queue
  var queueB: Queue
  
  var isEmpty: Bool {
    queueA.isEmpty && queueB.isEmpty
  }
  
  var size: Int {
    queueA.size + queueB.size
  }
  
  var peek: Element? {
    mutating get {
      shift()
      let ins = queueA.dequeue()
      if let ins = ins {
        queueB.enqueue(ins)
      }
      swap()
      return ins
    }
  }
  
  mutating func push(_ element: Element) {
    queueA.enqueue(element)
  }
  
  mutating func pop() -> Element? {
    shift()
    let ins = queueA.dequeue()
    swap()
    return ins
  }
  
  /// 保证 A 始终为 1，确保 A 随时可用
  private mutating func shift() {
    while queueA.size != 1 {
      if let ins = queueA.dequeue() {
        queueB.enqueue(ins)
      }
    }
  }
  
  private mutating func swap() {
    (queueA, queueB) = (queueB, queueA)
  }
}


struct GenericStack<Element>: Stack {
  private var stack: [Element] = []
  
  var isEmpty: Bool {
    return stack.isEmpty
  }
  
  var size: Int {
    return stack.count
  }
  
  var peek: Element? {
    return stack.last
  }
  
  mutating func push(_ element: Element) {
    stack.append(element)
  }
  
  mutating func pop() -> Element? {
    stack.popLast()
  }
}

func simplifyPath(_ path: String) -> String {
  let components = path.components(separatedBy: "/")
  
  var stack = GenericStack<String>()
  
  for item in components {
    if item == "." || item == "" {
      continue
    }
    
    if item == ".." {
      _ = stack.pop()
    } else {
      stack.push(item)
    }
  }
  
  var string = ""
  while !stack.isEmpty {
    if let popped = stack.pop() {
      string = popped + "/" + string
    }
  }
  string = "/" + string
  
  return string
}

func simplifyPath2(_ path: String) -> String {
  let components = path.components(separatedBy: "/")
  
  var stack = [String]()
  
  for item in components {
    if item == "." || item == "" {
      continue
    }
    
    if item == ".." {
      _ = stack.popLast()
    } else {
      stack.append(item)
    }
  }
  
  if stack.isEmpty {
    return "/"
  }
  return stack.reduce("") { partialResult, item in
    return partialResult + "/" + item
  }
}

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
/// 参考《iOS 面试之道》实现
func preorderTraversal3(_ root: TreeNode?) -> [Int] {
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

/// 先左结点都入队，否则从右边开始
/// 参考《iOS 面试之道》实现
func preorderTraversal4(_ root: TreeNode?) -> [Int] {
  var node = root
  var ret = [Int]()
  var stack = [TreeNode]()
  
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


/// 先一直到最左，然后 pop 处理
/// 基本等同于 inorderTraversal3
func inorderTraversal(_ root: TreeNode?) -> [Int] {
  var node = root
  var ret = [Int]()
  var stack = [TreeNode]()
  
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

/// 先找到最左的结点，依次保存，然后开始使用
/// 参考 MJ 实现
func inorderTraversal2(_ root: TreeNode?) -> [Int] {
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
func inorderTraversal3(_ root: TreeNode?) -> [Int] {
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

func quickSort(_ array: [Int]) -> [Int] {
  guard array.count > 0 else {
    return array
  }
  
  let pivot = array[array.count / 2]
  let left = array.filter { $0 < pivot }
  let middle = array.filter { $0 == pivot }
  let right = array.filter { $0 > pivot }
  return quickSort(left) + middle + quickSort(right)
}
