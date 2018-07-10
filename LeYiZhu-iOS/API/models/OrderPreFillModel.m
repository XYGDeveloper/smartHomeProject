//
//  OrderPreFillModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/11.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "OrderPreFillModel.h"

@implementation OrderPreFillModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"name":@"name",
             @"paperworkType":@"paperworkType",
             @"paperworkNum":@"paperworkNum",
             @"livePhone":@"livePhone",
             @"phone":@"phone",
             @"coupondetatilid":@"coupondetatilid",
             @"coupondenominat":@"coupondenominat",
             @"coupondiscount":@"coupondiscount",
             @"coupontype":@"coupontype",
             @"liveUserId":@"liveUserId"
             };
}

@end
