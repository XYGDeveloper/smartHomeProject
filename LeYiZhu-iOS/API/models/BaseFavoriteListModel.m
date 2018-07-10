//
//  BaseFavoriteListModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/9.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "BaseFavoriteListModel.h"
#import "FavoriteModel.h"

@implementation BaseFavoriteListModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"favoritelist":@"favorites"
             };
}

+ (NSValueTransformer *)favoritelistJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[FavoriteModel class]];
}

@end
