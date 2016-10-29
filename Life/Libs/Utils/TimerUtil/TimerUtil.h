//
//  TimerUtil.h
//  AirTouch
//
//  Created by Devin on 1/19/15.
//  Copyright (c) 2015 Honeywell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerUtil : NSObject


+(void)startTimer:(id)target timerTag:(NSString *)paramTag method:(SEL)paramMethod withInterval:(NSTimeInterval)paramInterval repeats:(BOOL)paramRepeats;
+(void)stopTimer:(NSString *)paramTag;
+(void)startTimer:(NSString *)paramTag;
+(void)invalidateTimer:(NSString *)paramTag;
+(NSTimer *)timerWithTag:(NSString *)paramTag;

@end
