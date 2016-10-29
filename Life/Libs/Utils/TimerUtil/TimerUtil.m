//
//  TimerUtil.m
//  AirTouch
//
//  Created by Devin on 1/19/15.
//  Copyright (c) 2015 Honeywell. All rights reserved.
//

#import "TimerUtil.h"

@interface TimerUtil ()

@end

static NSMutableDictionary *timerDictionary=nil;
@implementation TimerUtil

+(void)startTimer:(id)target timerTag:(NSString *)paramTag method:(SEL)paramMethod withInterval:(NSTimeInterval)paramInterval repeats:(BOOL)paramRepeats
{
    if ([[timerDictionary allKeys] containsObject:paramTag]) {
        [LogUtil Debug:@"startTimer have tag--" message:[NSString stringWithFormat:@"paramTag : %@ \n\r [timerDictionary allKeys]:%@",paramTag,[timerDictionary allKeys]]];
        return;
    }
    NSTimer *localListTimer=[NSTimer scheduledTimerWithTimeInterval:paramInterval target:target selector:paramMethod userInfo:[NSString stringWithString:paramTag] repeats:paramRepeats];
    
//    [[NSRunLoop currentRunLoop] addTimer:localListTimer forMode:NSDefaultRunLoopMode];
//    //打开下面一行输出runloop的内容就可以看出，timer确实已经被添加进去
//    //        NSLog(@"the thread's runloop: %@", [NSRunLoop currentRunLoop]);
//    
//    //打开下面一行，该线程的runloop就会运行起来，timer才会起作用
//    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
    [localListTimer setFireDate:[NSDate distantPast]];

    if (!timerDictionary) {
        timerDictionary=[[NSMutableDictionary alloc] initWithCapacity:10];
    }
    
    [timerDictionary setObject:localListTimer forKey:paramTag];
}

+(void)stopTimer:(NSString *)paramTag
{
    NSTimer *timer=(NSTimer *)[timerDictionary objectForKey:paramTag];
    if (timer != nil) {
        [timer setFireDate:[NSDate distantFuture]];
    }

}

+(void)startTimer:(NSString *)paramTag
{
    NSTimer *timer=(NSTimer *)[timerDictionary objectForKey:paramTag];
    if (timer != nil) {
        [timer setFireDate:[NSDate distantPast]];
    }
}

+(void)invalidateTimer:(NSString *)paramTag
{
    NSTimer *timer=(NSTimer *)[timerDictionary objectForKey:paramTag];
    if (timer != nil) {
        //取消定时器
        [timerDictionary removeObjectForKey:paramTag];
        [timer invalidate];
        timer = nil;
    }

}

+(NSTimer *)timerWithTag:(NSString *)paramTag
{
    return (NSTimer *)[timerDictionary objectForKey:paramTag];
}

@end
