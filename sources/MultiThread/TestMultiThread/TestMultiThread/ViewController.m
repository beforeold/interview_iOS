//
//  ViewController.m
//  TestMultiThread
//
//  Created by beforeold on 2022/9/15.
//

#import "ViewController.h"

typedef struct {
    long one;
    long two;
    long three;
    long four;
} MyStruct;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // [self testPlus];
    // [self testValueSafe];
     [self testStruct];
//    [self testArray];
}


- (void)testPlus {
    __auto_type size = sizeof(long);
    long *pointer = malloc(size);
    *pointer = 0;
    
    __auto_type count = 10000;
    for (int i = 0; i < count; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            __auto_type value = *pointer + 1;
            *pointer = value;
            NSLog(@"1 thread: %@, pointer: %ld\n", [NSThread currentThread].name, value);
        });
    }
}

- (void)testValueSafe {
    NSLog(@"int max: %ld", (long)LONG_MAX);
    
    __auto_type size = sizeof(long);
    long *pointer = malloc(size);
    *pointer = 0;
    
    __auto_type count = 9999;
    
    for (int i = 0; i < count; i++) {
        if (i % 3 == 0) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                __auto_type value = *pointer;
                NSAssert(value == 0 || value == LONG_MAX || value == LONG_MIN, @"");
                NSLog(@"1 thread: %@, pointer: %ld\n", [NSThread currentThread].name, value);
                *pointer = LONG_MAX;
            });
            continue;
        }
        
        if (i % 3 == 1) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                __auto_type value = *pointer;
                NSLog(@"2 thread: %@, pointer: %ld\n", [NSThread currentThread].name, value);
                NSAssert(value == 0 || value == LONG_MAX || value == LONG_MIN, @"");
                *pointer = 0;
            });
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            __auto_type value = *pointer;
            NSLog(@"3 thread: %@, pointer: %ld\n", [NSThread currentThread].name, value);
            NSAssert(value == 0 || value == LONG_MAX || value == LONG_MIN, @"");
            *pointer = LONG_MIN;
        });
    }
    
//    for (int i = 0; i < count; i++) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            __auto_type value = *pointer;
//            NSAssert(value == 0 || value == LONG_MAX, @"");
//            NSLog(@"3 thread: %@, pointer: %ld\n", [NSThread currentThread].name, value);
//        });
//    }
}

static bool equals(MyStruct str) {
    __auto_type one = str.one;
    __auto_type two = str.two;
    __auto_type three = str.three;
    __auto_type four = str.four;
    
    __auto_type ret = one == two && one == three && one == four;
    assert(ret);
    return ret;
}

- (void)testStruct {
    NSLog(@"int max: %ld", LONG_MAX);
    
    __auto_type size = sizeof(MyStruct);
    MyStruct *pointer = malloc(size);
    MyStruct new = {0, 0, 0, 0};
    *pointer = new;
    
    __auto_type count = 10000;
    
    for (int i = 0; i < count; i++) {
        if (i % 2 == 0) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                __auto_type value = *pointer;
                NSLog(@"2 thread: %@, pointer: %ld\n", [NSThread currentThread].name, value.one);
                NSAssert((value.one == 0 || value.one == LONG_MAX) && equals(value), @"");
                MyStruct new;
                new.one = LONG_MAX;
                new.two = LONG_MAX;
                new.three = LONG_MAX;
                new.four = LONG_MAX;
                
                *pointer = new;
            });
            continue;
        }
        
        if (i % 2 == 1) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                __auto_type value = *pointer;
                NSLog(@"2 thread: %@, pointer: %ld\n", [NSThread currentThread].name, value.one);
                NSAssert((value.one == 0 || value.one == LONG_MAX) && equals(value), @"");
                MyStruct new;
                new.one = 0;
                new.two = 0;
                new.three = 0;
                new.four = 0;
                
                *pointer = new;
            });
        }
    }
}


static void replaceArray(int *array, int num, int value) {
    for (int i = 0; i < num; i++) {
        array[i] = value;
    }
}

static void printArray(int *array, int num) {
    __auto_type string = [[NSMutableString alloc] init];
    __auto_type pre = array[0];
    for (int i = 0; i < num; i++) {
        if (i != 0) {
            [string appendString:@", "];
        }
        [string appendFormat:@"%d", array[i]];
        assert(array[i] == pre);
    }
    NSLog(@"%@", string);
}

- (void)testArray {
    NSLog(@"int max: %ld", (long)LONG_MAX);
    
    __auto_type num = 4;
    __auto_type size = sizeof(num * sizeof(int));
    int *pointer = malloc(size);
    replaceArray(pointer, num, 0);
    
    __auto_type count = 10000;
    
    for (int i = 0; i < count; i++) {
        if (i % 2 == 0) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                printArray(pointer, num);
                replaceArray(pointer, num, 0);
            });
            continue;
        }
        
        if (i % 2 == 1) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                printArray(pointer, num);
                replaceArray(pointer, num, INT_MAX);
            });
        }
    }
}


@end


NSMutableDictionary *_my_viewcontroller_xx_category_map;

static void ensureMap() {
    if (_my_viewcontroller_xx_category_map == nil) {
        _my_viewcontroller_xx_category_map = [NSMutableDictionary dictionary];
    }
}

static NSString *my_key(id obj, NSString *proName) {
    return [NSString stringWithFormat:@"%p_%@", obj, proName];
}


@implementation ViewController (XX)


- (NSString *)my_name {
    ensureMap();
    
    return _my_viewcontroller_xx_category_map[self.my_name_key];
}

- (void)setMy_name:(NSString *)my_name {
    ensureMap();
    _my_viewcontroller_xx_category_map[self.my_name_key] = my_name;
}

- (NSString *)my_name_key {
    return my_key(self, @"my_name");
}

@end
