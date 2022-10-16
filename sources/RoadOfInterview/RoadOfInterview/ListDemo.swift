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
