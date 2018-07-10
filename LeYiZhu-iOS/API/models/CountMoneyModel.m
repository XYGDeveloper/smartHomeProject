//
//  CountMoneyModel.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "CountMoneyModel.h"
#import "RoomPriceModel.h"

@implementation CountMoneyModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"payNum":@"payNum",
             @"liveDay":@"liveDay",
             @"roomPrice":@"roomPrice",
             @"deposit":@"deposit",
             @"stayMoneySum":@"stayMoneySum",
             @"depositSum":@"depositSum",
             @"actualPayment":@"actualPayment",
             @"coupondetatilid":@"coupondetatilid",
             @"coupontype":@"coupontype",
             @"coupondenominat":@"coupondenominat",
             @"coupondiscount":@"coupondiscount",
             @"totalDiscount":@"totalDiscount",
             };
}

+ (NSValueTransformer *)roomPriceJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[RoomPriceModel class]];
}
@end
