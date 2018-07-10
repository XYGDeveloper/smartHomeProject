//
//  GetBannerLists.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/14.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "GetBannerListsResponse.h"

@implementation GetBannerListsResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"baseBanner":@"data"
             };
}

+(NSValueTransformer *)baseBannerJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseBannerModel class]];
}


@end
