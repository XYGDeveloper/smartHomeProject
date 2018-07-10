//
//  BaseSearchResultModel.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "BaseSearchResultModel.h"

@implementation BaseSearchResultModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"searchResult":@"hotels"
             };
}

+ (NSValueTransformer *)searchResultJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[HotelSearchResultModel class]];
}


@end
