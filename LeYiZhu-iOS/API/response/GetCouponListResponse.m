//
//  GetCouponListResponse.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/3.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetCouponListResponse.h"

@implementation GetCouponListResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"baseCoupon":@"data"
             };
}

+(NSValueTransformer *)baseCouponJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseCouponListModel class]];
}

@end
