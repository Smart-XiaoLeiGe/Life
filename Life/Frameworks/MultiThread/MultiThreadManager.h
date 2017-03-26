//
//  MultiThreadManager.h
//  Life
//
//  Created by Wang, Devin on 3/13/17.
//  Copyright © 2017 wanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDManager.h"

@interface MultiThreadManager : NSObject

- (NSArray<NSString *>*)performTasks:(NSArray *)tasks mode:(MultiThreadMode)mode;
- (NSArray<NSString *>*)performTasks:(NSArray *)tasks mode:(MultiThreadMode)mode lastTask:(TaskBlcok)task lastTaskInMainThread:(BOOL)inMainThread;
- (void)cancelTask:(NSString *)taskID;
- (void)cancelAllTasks;

@end
