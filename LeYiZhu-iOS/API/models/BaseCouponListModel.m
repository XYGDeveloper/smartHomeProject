//
//  BaseCouponListModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/9.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "BaseCouponListModel.h"
#import "CouponModel.h"

@implementation BaseCouponListModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"couponjar":@"couponjar"
             };
}

+ (NSValueTransformer *)couponjarJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CouponModel class]];
}


@end
