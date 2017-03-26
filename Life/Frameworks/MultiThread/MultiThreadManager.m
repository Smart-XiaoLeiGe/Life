//
//  MultiThreadManager.m
//  Life
//
//  Created by Wang, Devin on 3/13/17.
//  Copyright © 2017 wanglei. All rights reserved.
//

#import "MultiThreadManager.h"


@interface MultiThreadManager ()
//该属性可以放在.h里面，用于动态替换实现类
@property (nonatomic, strong) id<MultiThreadProtocol> multiThreadManager;

@end

@implementation MultiThreadManager

- (instancetype)init{
    self = [super init];
    if (self) {
        self.multiThreadManager = [[GCDManager alloc] init];
    }
    return self;
}

- (NSArray<NSString *>*)performTasks:(NSArray *)tasks mode:(MultiThreadMode)mode{
    
     return [self.multiThreadManager performTasks:tasks mode:mode];
    
}
- (NSArray<NSString *>*)performTasks:(NSArray *)tasks mode:(MultiThreadMode)mode lastTask:(TaskBlcok)task lastTaskInMainThread:(BOOL)inMainThread{
    return [self.multiThreadManager performTasks:tasks mode:mode lastTask:task lastTaskInMainThread:inMainThread];
}
- (void)cancelTask:(NSString *)taskID{
    [self.multiThreadManager cancelTask:taskID];
}
- (void)cancelAllTasks{
    [self.multiThreadManager cancelAllTasks];
}






@end
