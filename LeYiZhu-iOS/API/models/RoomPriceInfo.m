//
//  RoomPriceInfo.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "RoomPriceInfo.h"
#import "RoomPriceModel.h"

@implementation RoomPriceInfo


+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"roomPrices":@"roomPrices",
             @"minPrice":@"minPrice",
             @"realPrice":@"realPrice",
             @"vipMinPrice":@"vipMinPrice",
             @"coupondetatilid":@"coupondetatilid",
             @"coupondenominat":@"coupondenominat",
             @"coupondiscount":@"coupondiscount",
             @"coupontype":@"coupontype",
             @"couponName":@"couponName"
             };
}

+ (NSValueTransformer *)roomPricesJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[RoomPriceModel class]];
}

@end
