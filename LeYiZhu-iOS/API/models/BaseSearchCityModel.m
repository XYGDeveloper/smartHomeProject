//
//  BaseSearchCityModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/14.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "BaseSearchCityModel.h"
#import "SearchCityModel.h"

@implementation BaseSearchCityModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"hcs":@"HCS"
             };
}

+ (NSValueTransformer *)hcsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[SearchCityModel class]];
}

@end
