//
//  LSTimeSlot.h
//  LSToolTimeSlot
//
//  Created by WangBiao on 2017/6/13.
//  Copyright © 2017年 LSRain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSTimeSlot : NSObject

+ (instancetype)sharedTimeSlot;

/**
 Is it within a certain period of time
 判断现在是否在某个时间段内

 @param beginHour startHour
 @param beginMinus startMinus
 @param endHour endHour
 @param endMinus endMinus
 @param isEarlyBack Is it early to return(是否提前返回)
 @param earlyBackMinus early return Minus
 @return YES/NO
 */
- (BOOL)isStockTradingBeginHour:(NSInteger)beginHour andBeginMinus:(NSInteger)beginMinus andEndHour:(NSInteger)endHour andEndMinus:(NSInteger)endMinus andIsEarlyBack:(BOOL)isEarlyBack andEarlyBackMinus:(NSInteger)earlyBackMinus;

@end
