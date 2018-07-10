//
//  BaseBannerModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/14.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "BaseBannerModel.h"
#import "BannerModel.h"

@implementation BaseBannerModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"banners":@"banners"
             };
}

+ (NSValueTransformer *)bannersJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[BannerModel class]];
}

@end
