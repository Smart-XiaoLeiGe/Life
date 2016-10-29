//
//  DateTimeUtil.h
//  AirTouch
//
//  Created by Devin on 1/14/15.
//  Copyright (c) 2015 Honeywell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTimeUtil : NSDateFormatter

+(DateTimeUtil *)instance;
-(NSString *)getNowDateTimeString;
-(NSDate *)getDateTimeFromString:(NSString *)dateTimeString;
- (NSInteger)compareCurrentTime:(NSDate*) compareDate;

//kenny add
+ (NSString *)getUTCFormateDate:(NSDate *)localDate;
+ (NSDate *)getDateFromUTCString:(NSString *)time;
+ (NSDate *)getDateFromLocalString:(NSString *)time;
+ (NSString *)getLocalStringFromUTCDate:(NSDate *)date;
//Xin Zhi 户外天气时间处理
+ (NSString *)getXinZhiLocalFormateDate:(NSDate *)localDate;
+ (NSDate *)getXinZhiDateFromLocalString:(NSString *)time;
+ (NSString *)getHourFromXinZhiFormateLocalString:(NSString *)time;
+ (NSString *)getDayFromXinZhiFormateLocalString:(NSString *)time;

+(BOOL)isNightNow:(NSInteger)firstHour firstMin:(NSInteger)paramFirstMin secondHour:(NSInteger)paramSecondHour secondMin:(NSInteger)paramSecondMin;

@end
