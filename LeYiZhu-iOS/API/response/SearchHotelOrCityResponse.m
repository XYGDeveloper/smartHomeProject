//
//  SearchHotelOrCityResponse.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/14.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "SearchHotelOrCityResponse.h"

@implementation SearchHotelOrCityResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"baseSearchCity":@"data"
             };
}

+(NSValueTransformer *)baseSearchCityJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseSearchCityModel class]];
}


@end
