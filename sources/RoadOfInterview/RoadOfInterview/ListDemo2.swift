//
//  ListDemo2.swift
//  RoadOfInterview
//
//  Created by beforeold on 2022/10/30.
//

import Foundation

struct ListDemo2 {
  func reverseArray(_ array: [Int]) -> [Int] {
    var array = array
    
    var begin = 0
    var end = array.count - 1
    while begin < end {
      array.swapAt(begin, end)
      
      begin += 1
      end -= 1
    }
    
    return array
  }
}
