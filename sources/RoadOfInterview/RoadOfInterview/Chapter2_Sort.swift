//
//  Chapter2_Sort.swift
//  RoadOfInterview
//
//  Created by beforeold on 2022/10/9.
//

import Foundation


func quickSort(_ array: [Int]) -> [Int] {
  guard array.count > 0 else {
    return array
  }
  
  let pivot = array[array.count / 2]
  let left = array.filter { $0 < pivot }
  let middle = array.filter { $0 == pivot }
  let right = array.filter { $0 > pivot }
  return quickSort(left) + middle + quickSort(right)
}
