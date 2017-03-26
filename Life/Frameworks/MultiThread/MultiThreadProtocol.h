//
//  MultiThreadProtocol.h
//  Life
//
//  Created by Wang, Devin on 3/13/17.
//  Copyright © 2017 wanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,MultiThreadMode){
    MultiThreadMode_AsyncSerial,
    MultiThreadMode_AsyncConcurrent,
    MultiThreadMode_SyncConcurrent,
    MultiThreadMode_SyncSerial,
};
typedef void(^TaskBlcok)(void);

@protocol MultiThreadProtocol <NSObject>
- (NSArray<NSString *>*)performTasks:(NSArray *)tasks mode:(MultiThreadMode)mode;
- (NSArray<NSString *>*)performTasks:(NSArray *)tasks mode:(MultiThreadMode)mode lastTask:(TaskBlcok)task lastTaskInMainThread:(BOOL)inMainThread;
- (void)cancelTask:(NSString *)taskID;
- (void)cancelAllTasks;
@end
