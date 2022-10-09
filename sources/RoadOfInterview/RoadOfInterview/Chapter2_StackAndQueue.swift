//
//  Chapter2_StackAndQueue.swift
//  RoadOfInterview
//
//  Created by beforeold on 2022/10/9.
//

import Foundation

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
