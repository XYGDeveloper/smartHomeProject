//
//  BaseLYZOrders.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/1/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "BaseLYZOrders.h"

@implementation BaseLYZOrders

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"orderJson":@"orderJson",
             @"hotelJson":@"hotelJson"
             };
}

+ (NSValueTransformer *)orderJsonJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OrderModel class]];
}

+ (NSValueTransformer *)hotelJsonJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OrderHotelModel class]];
}








@end
