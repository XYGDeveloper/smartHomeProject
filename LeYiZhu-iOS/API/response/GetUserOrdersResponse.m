//
//  GetUserOrdersResponse.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/1/21.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "GetUserOrdersResponse.h"

@implementation GetUserOrdersResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"baseiiOrder":@"data"
             };
}

+(NSValueTransformer *) baseiiOrderJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseIIOrder class]];
}


@end
