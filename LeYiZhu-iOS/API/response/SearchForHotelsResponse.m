//
//  SearchForHotelsResponse.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/1.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "SearchForHotelsResponse.h"

@implementation SearchForHotelsResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"baseSearchResult":@"data"
             };
}

+ (NSValueTransformer *)baseSearchResultJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseSearchResultModel class]];
}

@end
