//
//  GCDManager.m
//  Life
//
//  Created by Wang, Devin on 3/13/17.
//  Copyright © 2017 wanglei. All rights reserved.
//

#import "GCDManager.h"

@interface GCDManager ()
@property (strong, nonatomic) dispatch_group_t group;
@property (assign, nonatomic) BOOL isSync;
@property (strong, nonatomic) dispatch_queue_t gcdQueue;

@end

@implementation GCDManager
//MultiThreadMode_AsyncSerial,
//MultiThreadMode_AsyncConcurrent,
//MultiThreadMode_SyncConcurrent,
//MultiThreadMode_SyncSerial,
- (void)initGCDParameters:(MultiThreadMode)mode{
    switch (mode) {
        case MultiThreadMode_AsyncSerial:
        {
            self.isSync = NO;
            self.group = nil;
            self.gcdQueue = dispatch_queue_create("GCDManager", DISPATCH_QUEUE_SERIAL);
        }
            break;
        case MultiThreadMode_AsyncConcurrent:
        {
            self.isSync = NO;
            self.group = nil;
            self.gcdQueue = dispatch_queue_create("GCDManager", DISPATCH_QUEUE_CONCURRENT);
        }
            break;
        case MultiThreadMode_SyncConcurrent:
        {
            self.isSync = YES;
            self.group = nil;
            self.gcdQueue = dispatch_queue_create("GCDManager", DISPATCH_QUEUE_CONCURRENT);
        }
            break;
        case MultiThreadMode_SyncSerial:
        {
            self.isSync = YES;
            self.group = nil;
            self.gcdQueue = dispatch_queue_create("GCDManager", DISPATCH_QUEUE_SERIAL);
        }
            break;
            
        default:
            break;
    }
}

- (void)performTask:(TaskBlcok)task{
    if (self.isSync) {
        dispatch_sync(self.gcdQueue, task);
    }else{
        dispatch_async(self.gcdQueue, task);
    }
}

- (NSString *)modeString:(MultiThreadMode)mode{
    switch (mode) {
        case MultiThreadMode_AsyncSerial:
        {
            return @"MultiThreadMode_AsyncSerial";
        }
            break;
        case MultiThreadMode_AsyncConcurrent:
        {
            return @"MultiThreadMode_AsyncConcurrent";
        }
            break;
        case MultiThreadMode_SyncConcurrent:
        {
            return @"MultiThreadMode_SyncConcurrent";
        }
            break;
        case MultiThreadMode_SyncSerial:
        {
            return @"MultiThreadMode_SyncSerial";
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - MultiThreadProtocol
- (NSArray<NSString *>*)performTasks:(NSArray *)tasks mode:(MultiThreadMode)mode{
//    return nil;
    NSLog(@"Just performTasks start mode:%@",[self modeString:mode]);
    [self initGCDParameters:mode];
    for (TaskBlcok task in tasks) {
        [self performTask:task];
    }
    NSLog(@"Just performTasks end mode:%@",[self modeString:mode]);
    return nil;
}
- (NSArray<NSString *>*)performTasks:(NSArray *)tasks mode:(MultiThreadMode)mode lastTask:(TaskBlcok)task lastTaskInMainThread:(BOOL)inMainThread{
    return nil;
    
}
- (void)cancelTask:(NSString *)taskID{
    
}
- (void)cancelAllTasks{
    
}
@end
