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
}
