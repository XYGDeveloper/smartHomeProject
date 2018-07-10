//
//  GetOrderTimeResponse.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/13.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "GetOrderTimeResponse.h"


@implementation GetOrderTimeResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"baseOrderTime":@"data"
             };
}

+(NSValueTransformer *) baseOrderTimeJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[APIOrderTime class]];
}

@end
