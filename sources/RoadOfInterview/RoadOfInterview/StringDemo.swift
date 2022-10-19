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
    
    var i = num1.count
    var j = num2.count
    
    var temp = [Int]()
    
    while i >= 0 || j >= 0 || add > 0 {
      let left = i < 0 ? 0 : Int(String(char1[i]))!
      let right = j < 0 ? 0 : Int(String(char2[i]))!
      let value = left + right + add
      temp.append(value % 10)
      add = value / 10
    }
    
    return temp
      .reversed()
      .map { String($0) }
      .reduce("", +)
  }
}
