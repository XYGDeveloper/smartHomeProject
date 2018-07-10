//
//  CouponModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/9.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "CouponModel.h"

@implementation CouponModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"couponID":@"id",
             @"coupontype":@"coupontype",
             @"denominat":@"denominat",
             @"discount":@"discount",
             @"couponDesc":@"description",
             @"starttime":@"starttime",
             @"endtime":@"endtime",
             @"status":@"status",
             @"range":@"range",
             @"checkrange":@"checkrange",
             @"isavailable":@"isavailable",
             @"remark":@"remark",
             @"name":@"name"
             };
}

@end
