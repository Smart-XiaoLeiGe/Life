//
//  LogManager.h
//  Life
//
//  Created by Devin on 1/28/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import "LogUtil.h"
#import "UncaughtExceptionHandler.h"

#ifdef DEBUG
static const NSInteger ddLogLevel = DDLogLevelAll;
#else
static const NSInteger ddLogLevel = DDLogLevelDebug;
#endif

#define useCustomLog YES

@interface LogManager : NSObject

+(void)setLogManager;
+(void)setLogTag:(NSArray *)logTags;
+(void)debug:(NSString *)tag log:(NSString *)logString;
+(void)setLogEnable:(BOOL)paramIsLogEnabled;
+(void)setFilter:(NSString *)filterString;
+(void)setIsLogSaved:(BOOL)paramIsLogSaved;
+(NSString *)logFilePath;


@end
