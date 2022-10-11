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
}
