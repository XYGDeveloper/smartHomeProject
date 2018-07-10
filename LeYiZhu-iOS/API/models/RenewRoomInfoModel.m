//
//  LYZRenewRoomInfoModel.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/4/17.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "RenewRoomInfoModel.h"
#import "RoomPriceModel.h"

@implementation RenewRoomInfoModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"liveUserName":@"liveUserName",
             @"roomNum":@"roomNum",
             @"roomPrice":@"roomPrice",
             @"liveDay":@"liveDay",
             @"roomPriceSum":@"roomPriceSum",
             @"deposit":@"deposit"
             };
}

+ (NSValueTransformer *)roomPriceJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[RoomPriceModel class]];
}

@end
