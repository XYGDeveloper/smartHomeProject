//
//  GetUserCouponListResponse.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/9.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "GetUserCouponListResponse.h"

@implementation GetUserCouponListResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"baseCouponList":@"data"
             };
}

+(NSValueTransformer *)baseCouponListJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseCouponListModel class]];
}

@end
