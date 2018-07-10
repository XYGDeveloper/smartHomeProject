//
//  CreateOrderResponse.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/7.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "CreateOrderResponse.h"

@implementation CreateOrderResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"order":@"data"
             };
}

+(NSValueTransformer *)orderJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[createOrderModel class]];
}

@end
