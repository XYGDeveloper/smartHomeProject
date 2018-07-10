//
//  RoomPriceModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "RoomPriceModel.h"

@implementation RoomPriceModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"checkInDate":@"checkInDate",
             @"price":@"price",
             @"vipPrice":@"vipPrice"
             };
}

@end
