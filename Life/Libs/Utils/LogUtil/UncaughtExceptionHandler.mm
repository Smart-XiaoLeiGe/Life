//
//  UncaughtExceptionHandler.m
//  Life
//
//  Created by Devin on 1/31/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "UncaughtExceptionHandler.h"
#import <UIKit/UIKit.h>
#include <libkern/OSAtomic.h>
#include <execinfo.h>

NSString * const UncaughtExceptionHandlerSignalExceptionName = @"UncaughtExceptionHandlerSignalExceptionName";

NSString * const UncaughtExceptionHandlerSignalKey           = @"UncaughtExceptionHandlerSignalKey";

NSString * const UncaughtExceptionHandlerAddressesKey        = @"UncaughtExceptionHandlerAddressesKey";

NSString *kCrashNotification = @"kCrashNotification";

volatile int32_t UncaughtExceptionCount                      = 0;

const int32_t UncaughtExceptionMaximum                       = 10;

const NSInteger UncaughtExceptionHandlerSkipAddressCount     = 4;

const NSInteger UncaughtExceptionHandlerReportAddressCount   = 5;

@implementation UncaughtExceptionHandler

+ (NSArray *)backtrace
{
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (i = UncaughtExceptionHandlerSkipAddressCount;i < UncaughtExceptionHandlerSkipAddressCount +
         UncaughtExceptionHandlerReportAddressCount;i++)
    {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    return backtrace;
}

- (void)handleException:(NSException *)exception
{
    NSString *exceptionInfo = [NSString stringWithFormat:NSLocalizedString(
                                                 @"You can try to continue but the application may be unstable.\n"
                                                 @"%@\n%@", nil),
     [exception reason],
     [[exception userInfo] objectForKey:UncaughtExceptionHandlerAddressesKey]];
    [[NSNotificationCenter defaultCenter] postNotificationName:kCrashNotification object:exceptionInfo];
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    if ([[exception name] isEqual:UncaughtExceptionHandlerSignalExceptionName])
    {
        kill(getpid(), [[[exception userInfo] objectForKey:UncaughtExceptionHandlerSignalKey] intValue]);
    }
    else
    {
        [exception raise];
    }
}

+(void)InstallUncaughtExceptionHandler
{
    signal(SIGABRT, MySignalHandler);
    signal(SIGILL, MySignalHandler);
    signal(SIGSEGV, MySignalHandler);
    signal(SIGFPE, MySignalHandler);
    signal(SIGBUS, MySignalHandler);
    signal(SIGPIPE, MySignalHandler);
}

NSString* getAppInfo()
{
    NSString *appInfo = [NSString stringWithFormat:@"App : %@ %@(%@)\nDevice : %@\nOS Version : %@ %@\nUDID : %@\n",
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"],
                         [UIDevice currentDevice].model,
                         [UIDevice currentDevice].systemName,
                         [UIDevice currentDevice].systemVersion,
                         [UIDevice currentDevice].identifierForVendor];
    return appInfo;
}
void MySignalHandler(int signal)
{
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    if (exceptionCount > UncaughtExceptionMaximum)
    {
        return;
    }
    NSMutableDictionary *userInfo =
    [NSMutableDictionary
     dictionaryWithObject:[NSNumber numberWithInt:signal]
     forKey:UncaughtExceptionHandlerSignalKey];
    NSArray *callStack = [UncaughtExceptionHandler backtrace];
    [userInfo
     setObject:callStack
     forKey:UncaughtExceptionHandlerAddressesKey];
    [[[UncaughtExceptionHandler alloc] init]
     performSelectorOnMainThread:@selector(handleException:)
     withObject:
     [NSException
      exceptionWithName:UncaughtExceptionHandlerSignalExceptionName
      reason:
      [NSString stringWithFormat:
       NSLocalizedString(@"Signal %d was raised.\n"
                         @"%@", nil),
       signal, getAppInfo()]
      userInfo:
      [NSDictionary
       dictionaryWithObject:[NSNumber numberWithInt:signal]
       forKey:UncaughtExceptionHandlerSignalKey]]
     waitUntilDone:YES];
}
@end

