//
//  main.swift
//  TestMath
//
//  Created by beforeold on 2022/9/16.
//

import Foundation

print("Hello, World!")

// AB两地相距1000米，小明从A地点以30米/分钟的速度向B地点走，小白从B地点以20米/分钟的速度向A地点走，两人同时出发
// 用代码写出他们多少分钟后遇到？
do {
    
    func solution(dis: Double, s1: Double, s2: Double) -> Double {
        guard s1 >= 0, s2 >= 0 else {
            return 0
        }
        
        return dis / (s1 + s2)
    }

    let ret = solution(dis: 1000, s1: 30, s2: 20)
    print(ret)
}
// 对数组 ["2022年09月15日","2022年09月18日", "2022年10月15日", "2022年09月15日", "2022年09月18日", "2022年09月15日"] 去重同时进行排序
do {
    
    let array = ["2022年09月15日","2022年09月18日", "2022年10月15日", "2022年09月15日", "2022年09月18日", "2022年09月15日"]
    let ret = Array(Set(array)).sorted()
    print(ret)
}

// 使用递归方法计算99到1相加的计算结果。是否了解无尾随递归？
do {
    func sum(n: Int) -> Int {
        if n <= 1 { return n }
        return n + sum(n: n - 1)
    }
    print(sum(n: 100))
}

/*
- (void)viewDidLoad{
    [super viewDidLoad];
    dispatch_queue_t queue1 = dispatch_get_main_queue();
    dispatch_async(queue1, ^{
        NSLog(@"222 Hello?");
    });
    NSLog(@"aaaaaaa");
}
 */

do {
    let queue1 = DispatchQueue.main
    queue1.async {
        print("222 hello?")
    }
    print("aaaaaa")
}

