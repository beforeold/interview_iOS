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
