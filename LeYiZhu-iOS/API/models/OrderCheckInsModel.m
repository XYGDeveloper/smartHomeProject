//
//  OrderCheckInsModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/1/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "OrderCheckInsModel.h"
#import "RoomPriceModel.h"

@implementation OrderCheckInsModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"checkInDate":@"checkInDate",
             @"checkOutDate":@"checkOutDate",
             @"continueDate":@"continueDate",
             @"roomNum":@"roomNum",
             @"liveUserName":@"liveUserName",
             @"liveUserPhone":@"liveUserPhone",
             @"liveDay":@"liveDay",
             @"roomPrice":@"roomPrice",
             @"roomPriceSum":@"roomPriceSum",
             @"deposit":@"deposit"
            
             };
}

+ (NSValueTransformer *)roomPriceJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[RoomPriceModel class]];
}

@end
