//
//  BaseUserStays.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/22.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "BaseUserStays.h"
#import "UserStaysModel.h"

@implementation BaseUserStays

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"userStays":@"userStays"
             };
}

+(NSValueTransformer *) userStaysJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[UserStaysModel class]];
}


@end
