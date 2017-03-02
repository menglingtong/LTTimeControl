//
//  NSDate+LTCategory.m
//  LTTimeControl
//
//  Created by 孟令通 on 17/3/2.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "NSDate+LTCategory.h"

@implementation NSDate (LTCategory)

-(NSInteger)lt_hour
{
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitHour fromDate:now];
    
    NSInteger hour = [dateComponents hour];
    
    return hour;
}

-(NSInteger)lt_minute
{
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitMinute fromDate:now];
    
    NSInteger minute = [dateComponents minute];
    
    return minute;
}

-(NSDate *)lt_currentTime
{
    NSDate *date        = [NSDate date];                        // 获得时间对象
    
    NSTimeZone *zone    = [NSTimeZone systemTimeZone];          // 获得当前系统时区
    
    NSTimeInterval time = [zone secondsFromGMTForDate:date];    // 以秒为单位返回当前时间与系统格林尼治时间的差
    
    NSDate *nowDate     = [date dateByAddingTimeInterval:time]; // 然后把差的时间加上,就是当前系统准确的时间
    
    return nowDate;
}

@end
