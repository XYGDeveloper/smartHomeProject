//
//  LSTimeSlot.m
//  LSToolTimeSlot
//
//  Created by WangBiao on 2017/6/13.
//  Copyright © 2017年 LSRain. All rights reserved.
//

#import "LSTimeSlot.h"

@implementation LSTimeSlot

+ (instancetype)sharedTimeSlot{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (BOOL)isStockTradingBeginHour:(NSInteger)beginHour andBeginMinus:(NSInteger)beginMinus andEndHour:(NSInteger)endHour andEndMinus:(NSInteger)endMinus andIsEarlyBack:(BOOL)isEarlyBack andEarlyBackMinus:(NSInteger)earlyBackMinus{

    /*
     - You can add Saturday and Sunday to judge
     - 可添加!周六周日支持
     NSDate * date  = [NSDate date];
     NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
     NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:date];
     
    if (comps.weekday == 0 || comps.weekday == 7) {
        return NO;
    }
    */
    
    /**
     If you need to judge multiple time periods you can add `||`
     如果需要判断多个时间段,可以添加连接符`||`
     */
    return isEarlyBack ? [self isBetweenFromHour:beginHour andMinus:beginMinus toHour:endHour andMinus:(endMinus - earlyBackMinus)] : [self isBetweenFromHour:beginHour andMinus:beginMinus toHour:endHour andMinus:endMinus];
}

- (BOOL)isBetweenFromHour:(NSInteger)fromHour andMinus:(NSInteger)fromMinus toHour:(NSInteger)toHour andMinus:(NSInteger)toMinus
{
    NSDate *dateFrom = [self getCustomDateWithHour:fromHour andMinus:fromMinus];
    NSDate *dateTo = [self getCustomDateWithHour:toHour andMinus:toMinus];
    NSDate *currentDate = [NSDate date];
    
    return [currentDate compare:dateFrom] == NSOrderedDescending && [currentDate compare:dateTo] == NSOrderedAscending;
}

/**
 
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 
 */
- (NSDate *)getCustomDateWithHour:(NSInteger)hour andMinus:(NSInteger)minus
{
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    /// 设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    [resultComps setMinute:minus];
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    return [resultCalendar dateFromComponents:resultComps];
}

@end
