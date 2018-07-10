//
//  GetOrderDetailResponse.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "GetOrderDetailResponse.h"

@implementation GetOrderDetailResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"baseOrderDetail":@"data"
             };
}

+(NSValueTransformer *)baseOrderDetailJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseOrderDetailModel class]];
}




@end
