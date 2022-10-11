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
