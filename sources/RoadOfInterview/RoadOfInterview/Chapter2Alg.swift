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
