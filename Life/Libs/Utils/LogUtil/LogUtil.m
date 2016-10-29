//
//  LogUtil.m
//  AirTouch
//
//  Created by Devin on 1/14/15.
//  Copyright (c) 2015 Honeywell. All rights reserved.
//

#import "LogUtil.h"


static LogUtil *instance = nil;
static NSString *logFilePath=@"";
static NSString *logFileName=@"";
static LogLevel logFileLevel=LogDebug;
static BOOL isLogSaved=NO;
static BOOL isLogEnabled=YES;
static NSString *filterStr=@"";


@implementation LogUtil

//+ (instancetype)defaultLogUtil
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance = [[LogUtil alloc] init];
//        instance.isLogEnabled = YES;
//        instance.isLogSaved=NO;
//        instance.logFileLevel=LogDebug;
//    });
//    return instance;
//}

//一些初始化可以在这个函数中
+(void)initialize
{
}

+(NSString *)logFileName
{
    return logFileName==nil?@"log":logFileName;
}

+(void)setLogFileName:(NSString *)paramlogFileName
{
    if (![logFileName isEqualToString:paramlogFileName]) {
        logFileName=paramlogFileName;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *LogDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Log"];
        [fileManager createDirectoryAtPath:LogDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        logFilePath=[LogDirectory stringByAppendingFormat:@"/%@%@",logFileName,@".log"];
//        NSLog(@"self.logFilePath : %@",logFilePath);
    }
}

+(LogLevel)logFileLevel
{
    return logFileLevel;
}

+(void)setLogFileLevel:(LogLevel)paramlogFileLevel
{
    if (logFileLevel!=paramlogFileLevel) {
        logFileLevel=paramlogFileLevel;
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

+(BOOL)isLogEnabled
{
    return isLogEnabled;
}
+(void)setIsLogEnabled:(BOOL)paramIsLogEnabled
{
    if (isLogEnabled!=paramIsLogEnabled) {
        isLogEnabled=paramIsLogEnabled;
    }
}

+(void)setFilter:(NSString *)filterString
{
    if (![filterStr isEqualToString:filterString]) {
        filterStr=filterString;
    }
}


+(void)log:(LogLevel)paramLeval tag:(NSString *)paramTag message:(NSObject *)paramMessage
{
    NSString *logString=@"";
    if (self.isLogEnabled) {
        logString=[NSString stringWithFormat:@"%@-->%@-->%@",logLevelString(paramLeval),paramTag,paramMessage];
        if (![paramTag isEqualToString:filterStr] && ![filterStr isEqualToString:@""]) {
            
        }else
        {
            NSLog(@"%@",logString);
        }
    }
    if (self.isLogSaved && paramLeval>=logFileLevel) {
        logString=[NSString stringWithFormat:@"%@_%@",[[DateTimeUtil instance] getNowDateTimeString],logString];
        if ([[NSFileManager defaultManager] fileExistsAtPath:logFilePath]) {
            NSFileHandle  *outFile;
            NSData *buffer;
            
            outFile = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
            
            if(outFile == nil)
            {
                NSLog(@"Open of file for writing failed");
            }
            
            //找到并定位到outFile的末尾位置(在此后追加文件)
            [outFile seekToEndOfFile];
            
            //读取inFile并且将其内容写到outFile中
            NSString *bs = [NSString stringWithFormat:@"\n%@",logString];
            buffer = [bs dataUsingEncoding:NSUTF8StringEncoding];
            
            [outFile writeData:buffer];
            
            //关闭读写文件
            [outFile closeFile];
        }else
        {
            [logString writeToFile:logFilePath atomically:NO encoding:NSUTF8StringEncoding error:nil];
        }
    }
}

+(void)Debug:(NSString *)paramTag message:(NSObject *)paramMessage
{
    [self log:LogDebug tag:paramTag message:paramMessage];
}

@end
