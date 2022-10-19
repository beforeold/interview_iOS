//
//  ViewController.swift
//  RoadOfInterview
//
//  Created by beforeold on 2022/9/25.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
     
    test()
  }
  
  func test() {
    ListDemo.test()
    StringDemo.test()
    
    let ret = NSStringDemo().addStrings(withNum1: "123", string2: "4567")
    assert(ret == String(123 + 4567))
    
    print("all done")
  }
  
}

