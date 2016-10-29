//
//  LogManager.m
//  Life
//
//  Created by Devin on 1/28/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "LogManager.h"


static NSArray *tagsArray=nil;
static BOOL isLogEnabled=YES;
static BOOL isLogSaved=NO;
static NSString *filterStr=@"";

@implementation LogManager

+(void)setLogManager
{
    if (useCustomLog) {
       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [LogUtil setLogFileName:[formatter stringFromDate:[NSDate date]]];
        [LogUtil setIsLogSaved:YES];
        [LogUtil setFilter:@""];
#ifdef DEBUG
        [LogUtil setIsLogEnabled:YES];
#else
        [LogUtil setIsLogEnabled:NO];
#endif
    }else
    {
        [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
        
        DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
        fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
        [DDLog addLogger:fileLogger];
    }
    
    [UncaughtExceptionHandler InstallUncaughtExceptionHandler];
    NSSetUncaughtExceptionHandler(&catchCrashLog);
}

void catchCrashLog(NSException *exception)
{
    NSArray *stackArray = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason：%@\nException name：%@\nException stack：%@",name, reason, stackArray];
    
    [LogUtil Debug:@"crash" message:exceptionInfo];
}

+(void)setLogTag:(NSArray *)logTags
{
    tagsArray=logTags;
}

+(void)debug:(NSString *)tag log:(NSString *)logString
{
    if (useCustomLog) {
        [LogUtil Debug:tag message:logString];
    }else
    {
        if ([self isLogEnabled] &&([[self filterStr] isEqualToString:@""] || [tag isEqualToString:[self filterStr]])) {
            DDLogDebug(@"%@_%@",tag,logString);
        }
    }
}

+(BOOL)isLogEnabled
{
    return isLogEnabled;
}
+(void)setLogEnable:(BOOL)paramIsLogEnabled
{
    if (isLogEnabled!=paramIsLogEnabled) {
        isLogEnabled=paramIsLogEnabled;
    }
}

+(BOOL)isLogSaved
{
    return isLogSaved;
}
+(void)setIsLogSaved:(BOOL)paramIsLogSaved
{
    if (isLogSaved!=paramIsLogSaved) {
        isLogSaved=paramIsLogSaved;
    }
}

+(NSString *)filterStr
{
    return filterStr;
}

+(void)setFilter:(NSString *)filterString
{
    [LogUtil setFilter:filterString];
    if (![filterStr isEqualToString:filterString]) {
        filterStr=filterString;
    }
}

+(void)addLogToLogFile:(NSString *)logInfo
{
    [logInfo writeToFile:[self logFilePath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+(NSString *)logFilePath
{
    DDLogFileInfo *logInfo = nil;
    for (id <DDLogger> logger in [DDLog allLoggers]) {
        if ([logger isKindOfClass:[DDFileLogger class]]) {
            logInfo = [(DDFileLogger *)logger currentLogFileInfo];
            break;
        }
    }
    return  logInfo.filePath;
}


@end
