//
//  SearchForKeywordsResponse.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "SearchForKeywordsResponse.h"

@implementation SearchForKeywordsResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"searchForKeyModel":@"data"
             };
}

+(NSValueTransformer *)searchForKeyModelJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseSearchForKeywordsModel class]];
}

@end
