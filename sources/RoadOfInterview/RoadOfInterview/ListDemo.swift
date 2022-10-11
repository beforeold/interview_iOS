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
}
