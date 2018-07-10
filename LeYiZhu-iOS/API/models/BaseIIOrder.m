//
//  BaseIIOrder.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/1/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "BaseIIOrder.h"
#import "BaseLYZOrders.h"

@implementation BaseIIOrder

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"orders":@"orders"
             };
}

+(NSValueTransformer *) ordersJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[BaseLYZOrders class]];
}


@end
