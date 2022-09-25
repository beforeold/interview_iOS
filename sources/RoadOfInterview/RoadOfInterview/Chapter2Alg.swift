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
}
