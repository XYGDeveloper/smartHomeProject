//
//  BaseCouponModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/3.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "BaseCouponModel.h"
#import "CouponModel.h"

@implementation BaseCouponModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"couponjar":@"couponjar"
             };
}

+(NSValueTransformer *)couponjarJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CouponModel class]];
}


@end
