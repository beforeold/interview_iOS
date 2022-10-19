//
//  ListDemo.swift
//  RoadOfInterview
//
//  Created by beforeold on 2022/10/11.
//

import Foundation

struct ListDemo {
  func reverse<T>(_ array: inout [T], start: Int, end: Int) {
    var start = start
    var end = end
    while start < end {
      array.swapAt(start, end)
      start += 1
      end -= 1
    }
  }
  
  func reverse(string: String) -> String {
    var chars = string.map { $0 }
    reverse(&chars, start: 0, end: chars.count - 1)
    return String(chars)
  }
  
  func reverseWords(of string: String) -> String {
    var chars = string.map { $0 }
    var start = 0
    
    for i in 0..<chars.count {
      if i == chars.count - 1 || chars[i + 1] == " " {
        reverse(&chars, start: start, end: i)
        start = i + 2
      }
    }
    
    return String(chars)
  }
}

extension ListDemo {
  static func test() {
    testReverse()
    testMinStack()
  }
  
  static func testReverse() {
    do {
      var array = [2, 4, 6]
      ListDemo().reverse(&array, start: 0, end: array.count - 1)
      assert(array == [6, 4, 2])
    }
    
    do {
      var array = [2, 4]
      ListDemo().reverse(&array, start: 0, end: array.count - 1)
      assert(array == [4, 2])
    }
    
    do {
      let ret = ListDemo().reverse(string: "it was monday")
      assert(ret == "yadnom saw ti")
    }
    
    do {
      let ret = ListDemo().reverseWords(of: "it was monday")
      assert(ret == "ti saw yadnom")
    }
  }
  
  static func testMinStack() {
    let stack = MinStack()
    stack.push(3)
    stack.push(4)
    stack.push(8)
    stack.push(7)
    stack.push(2)
    
    stack.showStack()
    
    while stack.count > 0 {
      print("top: \(stack.top()), min: \(stack.getMin())")
      stack.pop()
    }
  }
}

extension ListDemo {
  // 给定两个整数数组A和B，A只比B多一个元素，其它元素都一样，找出多的那个元素
  func extraElement(_ a1: [Int], _ a2: [Int]) -> Int {
    let map1 = Dictionary(a1.map { ($0, 1) }, uniquingKeysWith: +)
    let map2 = Dictionary(a1.map { ($0, 1) }, uniquingKeysWith: +)
    
    if map1.count == map2.count {
      for (num, count) in map1 {
        if count != map2[num] {
          return num
        }
      }
      return -1
    } else {
      let allKeys1 = Set(map1.keys)
      let allKeys2 = Set(map2.keys)
      let sub = allKeys1.subtracting(allKeys2)
      return sub.first!
    }
  }
  
  func _2_extraElement(_ a1: [Int], _ a2: [Int]) -> Int {
    var ret = [Int]()
    
    var set1 = Set(a1)
    
    for item in a2 {
      if set1.contains(item) {
        ret.append(item)
        set1.remove(item)
      }
    }
    
    return ret.first!
  }
  
  func _3_extraElement(_ a1: [Int], _ a2: [Int]) -> Int {
    let set1 = Set(a1)
    let set2 = Set(a2)
    return set1.subtracting(set2).first!
  }
}

extension ListDemo {
  class MinStack {
    private var stack = [(element: Int, minValue: Int)]()
    
    init() {
      stack.append((.max, .max))
    }
    
    func push(_ val: Int) {
      let newMin = min(stack.last!.minValue, val)
      stack.append((val, newMin))
    }
    
    func pop() {
      stack.removeLast()
    }
    
    func top() -> Int {
      return stack.last!.element
    }
    
    func getMin() -> Int {
      return stack.last!.minValue
    }
    
    var count: Int {
      return stack.count - 1
    }
    
    func showStack() {
      print(stack[1...])
    }
  }
}

extension Array {
  mutating func push(_ element: Element) {
    append(element)
  }
  
  mutating func pop() -> Element {
    return removeLast()
  }
  
  func stackPeek() -> Element? {
    return last
  }
}

extension Array {
  mutating func enqueue(_ element: Element) {
    append(element)
  }
  
  mutating func dequeue() -> Element {
    return removeFirst()
  }
  
  func queuePeek() -> Element? {
    return first
  }
}

extension ListDemo {
  class MyQueue {
    typealias Element = Int
    
    private var left = [Element]()
    private var right = [Element]()
    
    func enqueue(_ element: Element) {
      left.push(element)
    }
    
    func dequeue() -> Element {
      shift()
      
      return right.pop()
    }
    
    var count: Int {
      return left.count + right.count
    }
    
    func peek() -> Element? {
      shift()
      return right.stackPeek()
    }
    
    func shift() {
      if right.count > 0 {
        return
      }
      
      while left.count > 0 {
        right.push(left.pop())
      }
    }
  }
}

extension ListDemo {
  class MyStack {
    typealias Element = Int
    
    private var left = [Element]()
    private var right = [Element]()
    
    func push(_ element: Element) {
      left.append(element)
    }
    
    func pop() -> Element {
      ensureLeftWithOneElement()
      
      return left.dequeue()
    }
    
    var count: Int {
      return left.count + right.count
    }
    
    func peek() -> Element? {
      guard count > 0 else {
        return nil
      }
      
      ensureLeftWithOneElement()
      
      let ret = left.dequeue()
      push(ret)
      return ret
    }
    
    func ensureLeftWithOneElement() {
      if left.count == 0 {
        (left, right) = (left, right)
      }
      
      while left.count > 1 {
        right.enqueue(left.dequeue())
      }
    }
  }
}

