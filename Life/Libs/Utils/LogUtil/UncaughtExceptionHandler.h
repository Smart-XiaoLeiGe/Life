//
//  UncaughtExceptionHandler.h
//  Life
//
//  Created by Devin on 1/31/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *kCrashNotification;

@interface UncaughtExceptionHandler : NSObject

+(void)InstallUncaughtExceptionHandler;
@end
