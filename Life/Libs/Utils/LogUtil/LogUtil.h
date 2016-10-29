//
//  LogUtil.h
//  AirTouch
//
//  Created by Devin on 1/14/15.
//  Copyright (c) 2015 Honeywell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateTimeUtil.h"

typedef NS_ENUM(NSInteger, LogLevel) {
    LogVer,
    LogInfo,
    LogDebug,
    LogWarning,
    LogError
};

//如果ENUM不是从0开始，那么可以用字典
//NSDictionary *testDic = @{@"a": @"first",
//                          @"b": @"second",
//                          @"c": @"third"
//                          };
//

#define logLevelString(LogLevel) [@[@"LogVer",@"LogInfo",@"LogDebug",@"LogWarning",@"LogError"] objectAtIndex:LogLevel]

@interface LogUtil : NSObject
{
//    NSString *logFileName;
}

//@property (nonatomic,assign) BOOL isLogEnabled;
//@property (nonatomic,assign) BOOL isLogSaved;
//@property (nonatomic,assign) LogLevel logFileLevel;
//@property (nonatomic,copy) NSString *logFileName;


//+ (instancetype)defaultLogUtil;

/**
 *  打印输出日志，并根据isLogEnabled：判断是否打印日志；  isLogSaved：判断是否存储日志  logFileLevel：存储日志的级别。
 *
 *  @param paramLeval   log等级
 *  @param paramTag     用于标记哪个log
 *  @param paramMessage log信息
 */
+(void)log:(LogLevel)paramLeval tag:(NSString *)paramTag message:(NSObject *)paramMessage;


//以下都是set get 方法
+(NSString *)logFileName;
+(void)setLogFileName:(NSString *)paramLogFileName;

+(LogLevel)logFileLevel;
+(void)setLogFileLevel:(LogLevel)paramLogFileLevel;

+(BOOL)isLogSaved;
+(void)setIsLogSaved:(BOOL)paramIsLogSaved;

+(BOOL)isLogEnabled;
+(void)setIsLogEnabled:(BOOL)paramIsLogEnabled;

+(void)Debug:(NSString *)paramTag message:(NSObject *)paramMessage;
+(void)setFilter:(NSString *)filterString;

@end

