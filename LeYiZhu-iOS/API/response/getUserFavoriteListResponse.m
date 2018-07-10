//
//  getUserFavoriteListResponse.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/9.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "getUserFavoriteListResponse.h"

@implementation getUserFavoriteListResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"baseFavoriteList":@"data"
             };
}

+(NSValueTransformer *)baseFavoriteListJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseFavoriteListModel class]];
}


@end
