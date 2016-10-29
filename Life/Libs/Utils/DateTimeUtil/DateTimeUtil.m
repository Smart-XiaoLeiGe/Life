//
//  DateTimeUtil.m
//  AirTouch
//
//  Created by Devin on 1/14/15.
//  Copyright (c) 2015 Honeywell. All rights reserved.
//

#import "DateTimeUtil.h"
static DateTimeUtil *_instance=NULL;

@implementation DateTimeUtil

+(DateTimeUtil *)instance
{
    if(_instance==NULL)
    {
        _instance=[[DateTimeUtil alloc]init];
        [_instance setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return _instance;
}
-(NSString *)getNowDateTimeString
{
    return [self stringFromDate:[NSDate date]];
}

-(NSDate *)getDateTimeFromString:(NSString *)dateTimeString
{
    return [self dateFromString:dateTimeString];
}

//天津那边要求改动的方法
+ (NSString *)getUTCFormateDate:(NSDate *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];//yyyy-MM-dd'T'HH:mm:ssZ
    return [dateFormatter stringFromDate:localDate];
}

+(NSDate *)getDateFromUTCString:(NSString *)time
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
     NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];//yyyy-MM-dd'T'HH:mm:ssZZZ
    [dateFormatter setLocale:[NSLocale systemLocale]];
    return [dateFormatter dateFromString:time];
}

+(NSDate *)getDateFromLocalString:(NSString *)time
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];//yyyy-MM-dd'T'HH:mm:ssZZZ
    [dateFormatter setLocale:[NSLocale systemLocale]];
    return [dateFormatter dateFromString:time];
}

+(NSString *)getLocalStringFromUTCDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];//yyyy-MM-dd'T'HH:mm:ssZ
    return [dateFormatter stringFromDate:date];
}

//心知
+(NSString *)getXinZhiLocalFormateDate:(NSDate *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale systemLocale]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];//yyyy-MM-dd'T'HH:mm:ssZ
    return [dateFormatter stringFromDate:localDate];
}

+(NSDate *)getXinZhiDateFromLocalString:(NSString *)time
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];//yyyy-MM-dd'T'HH:mm:ssZZZ
    [dateFormatter setLocale:[NSLocale systemLocale]];
    return [dateFormatter dateFromString:time];
}

+(NSString *)getDayFromXinZhiFormateLocalString:(NSString *)time
{
    NSDate *date = [DateTimeUtil getXinZhiDateFromLocalString:time];
    if (date == nil) {
        return @"";
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
    NSInteger day = [components day];
    
    NSDate *now = [NSDate date];
    NSDateComponents *nowComponents = [calendar components:(NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:now];
    NSInteger nowDay = [nowComponents day];
    if (day == nowDay) {
        return @"Today";
    } else if (day > nowDay) {
        return @"Tomorrow";
    }
    return @"";
}

+(NSString *)getHourFromXinZhiFormateLocalString:(NSString *)time
{
    //NSString * time = @"2015-10-10T15:00:00+08:00";
    NSDate * date = [DateTimeUtil getXinZhiDateFromLocalString:time];
    if (date == nil) {
        return @"";
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
    NSInteger hour = [components hour];
    
    return [NSString stringWithFormat:@"%li:00",(long)hour];
}

//之前的方法
//+ (NSString *)getUTCFormateDate:(NSDate *)localDate
//{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
//    [dateFormatter setTimeZone:timeZone];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];//yyyy-MM-dd'T'HH:mm:ssZ
//    return [dateFormatter stringFromDate:localDate];
//}
//
//+(NSDate *)getDateFromUTCString:(NSString *)time
//{
//    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
//    //NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
//    //[dateFormatter setTimeZone:timeZone];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];//yyyy-MM-dd'T'HH:mm:ssZZZ
//    [dateFormatter setLocale:[NSLocale systemLocale]];
//    return [dateFormatter dateFromString:time];
//}


+(BOOL)isNightNow:(NSInteger)firstHour firstMin:(NSInteger)paramFirstMin secondHour:(NSInteger)paramSecondHour secondMin:(NSInteger)paramSecondMin
{
    NSDate * now = [NSDate date];
    NSCalendar * cal = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents * todayComps = [cal components:unitFlags fromDate:now];
    
    NSDateComponents *fireComps = [[NSDateComponents alloc] init];
    [fireComps setDay:todayComps.day];
    [fireComps setMonth:todayComps.month];
    [fireComps setYear:todayComps.year];
    [fireComps setHour:firstHour];
    [fireComps setMinute:paramFirstMin];
    [fireComps setSecond:0];
    NSDate * morningDate = [cal dateFromComponents:fireComps];
    
    NSDateComponents *nightComps = [[NSDateComponents alloc] init];
    [nightComps setDay:todayComps.day];
    [nightComps setMonth:todayComps.month];
    [nightComps setYear:todayComps.year];
    [nightComps setHour:paramSecondHour];
    [nightComps setMinute:paramSecondMin];
    [nightComps setSecond:0];
    NSDate * nightDate = [cal dateFromComponents:nightComps];
    if ([now compare:morningDate]==NSOrderedDescending && [now compare:nightDate]==NSOrderedAscending) {
        return NO;
    }else
    {
        return YES;
    }
}

/**
 * 计算指定时间与当前的时间差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
-(NSString *) compareCurrentTimeString:(NSDate*) compareDate
//
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

/**
 *  比较时间前后
 *
 *  @param compareDate 要比较的时间
 *
 *  @return return value >0 ,compareDate 早于 当前时间
 */
- (NSInteger)compareCurrentTime:(NSDate*) compareDate
{
    [LogUtil Debug:@"refreshSessionID compareCurrentTime" message:[NSString stringWithFormat:@"compareDate:%@ now:%@",compareDate,[self getDateTimeFromString:[self getNowDateTimeString]]]];
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    return timeInterval/60;
}
@end
