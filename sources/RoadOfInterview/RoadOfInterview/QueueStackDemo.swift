//
//  QueueStackDemo.swift
//  RoadOfInterview
//
//  Created by beforeold on 2022/10/19.
//

import Foundation

struct QueueStackDemo {
}

extension QueueStackDemo {
  // https://leetcode.cn/problems/implement-queue-using-stacks/solution/yong-zhan-shi-xian-dui-lie-by-leetcode/
  class MyQueue {
    typealias Element = Int
    
    private var front: Element?
    private var s1 = [Element]()
    private var s2 = [Element]()
    
    func push(_ element: Element) {
      if s1.isEmpty {
        front = element
      }
      s1.push(element)
    }
    
    func pop() -> Element {
      if s2.isEmpty {
        while s1.count > 0 {
          s2.push(s2.pop())
          front = nil
        }
      }
      
      return s2.pop()
    }
    
    func peek() -> Element? {
      if s2.count > 0 {
        return s2.stackPeek()
      }
      return front
    }
  }
}

extension QueueStackDemo {
  class MyStack {
    typealias Element = Int
    
    private var front: Element?
    private var q1 = [Element]()
    private var q2 = [Element]()
    
    func push(_ element: Element) {
      q2.enqueue(element)
      while q1.count > 0 {
        q2.enqueue(q1.dequeue())
      }
      (q1, q2) = (q2, q1)
    }
    
    func pop() -> Element {
      return q1.dequeue()
    }
    
    func peek() -> Element? {
      return q1.queuePeek()
    }
  }
  
  // https://leetcode.cn/problems/implement-stack-using-queues/solution/yong-dui-lie-shi-xian-zhan-by-leetcode-solution/
  class MyStack2 {
    typealias Element = Int
    
    private var front: Element?
    private var q1 = [Element]()
    
    func push(_ element: Element) {
      q1.enqueue(element)
      
      for _ in 0..<(q1.count - 1) {
        q1.enqueue(q1.dequeue())
      }
    }
    
    func pop() -> Element {
      return q1.dequeue()
    }
    
    func peek() -> Element? {
      return q1.queuePeek()
    }
  }
}
