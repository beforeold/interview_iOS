//
//  StringDemo.swift
//  RoadOfInterview
//
//  Created by beforeold on 2022/10/19.
//

import Foundation

struct StringDemo {
  func addStrings(_ num1: String, _ num2: String) -> String {
    var add = 0
    let char1 = num1.map { $0 }
    let char2 = num2.map { $0 }
    
    var i = char1.count - 1
    var j = char2.count - 1
    
    var temp = [Int]()
    
    while i >= 0 || j >= 0 || add > 0 {
      let left = i < 0 ? 0 : Int(String(char1[i]))!
      let right = j < 0 ? 0 : Int(String(char2[j]))!
      let value = left + right + add
      temp.append(value % 10)
      add = value / 10
      
      i -= 1
      j -= 1
    }
    
    return temp
      .reversed()
      .map { String($0) }
      .reduce("", +)
  }
  
  func multiply(_ num1: String, _ num2: String) -> String {
    if num1 == "0" || num2 == "0" {
      return "0"
    }
    
    let char1 = num1.map { $0 }
    let char2 = num2.map { $0 }
    
    let count1 = char1.count
    let count2 = char2.count
    
    
    var ret = "0"
    
    for i in (0..<count2).reversed() {
      var temp = [Int]()
      let zeroCount = count2 - 1 - i
      for _ in 0..<zeroCount {
        temp.append(0)
      }
      
      var add = 0
      let right = Int(String(char2[i]))!
      for j in (0..<count1).reversed() {
        let left = Int(String(char1[j]))!
        let value = left * right + add
        temp.append(value % 10)
        add = value / 10
      }
      
      if add > 0 {
        temp.append(add % 10)
      }
      
      let partial = temp.reversed().map { String($0) }.reduce("", +)
      ret = addStrings(ret, partial)
    }
    
    return ret
  }
}

extension StringDemo {
  static func test() {
    assert(StringDemo().addStrings("123", "4567") == String(123 + 4567))
    
    
    assert(StringDemo().multiply("123", "4567") == String(123 * 4567))
  }
}
