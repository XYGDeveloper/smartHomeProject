//
//  StayListResponse.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/22.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "StayListResponse.h"

@implementation StayListResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"baseStays":@"data"
             };
}

+(NSValueTransformer *) baseStaysJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseUserStays class]];
}



@end
