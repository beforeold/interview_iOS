//
//  NSStringDemo.m
//  RoadOfInterview
//
//  Created by beforeold on 2022/10/19.
//

#import "NSStringDemo.h"

@implementation NSStringDemo

- (NSString *)addStringsWithNum1:(NSString *)num1 string2:(NSString *)num2 {
  NSInteger i = num1.length - 1;
  NSInteger j = num2.length - 1;
  NSInteger add = 0;
  NSMutableArray *array = [NSMutableArray array];
  
  while (i >= 0 || j >= 0 || add > 0) {
    NSInteger left = i < 0 ? 0 : ([num1 characterAtIndex:i] - '0');
    NSInteger right = j < 0 ? 0 : ([num2 characterAtIndex:j] - '0');
    NSInteger ret = left + right + add;
    NSInteger value = ret % 10;
    add = ret / 10;
    
    [array addObject:@(value)];
    
    i -= 1;
    j -= 1;
  }
  
  NSMutableString *ret = [NSMutableString string];
  [array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSNumber * _Nonnull obj,
                                                                       NSUInteger idx,
                                                                       BOOL * _Nonnull stop) {
    [ret appendString:obj.description];
  }];
  
  return ret;
}

@end
