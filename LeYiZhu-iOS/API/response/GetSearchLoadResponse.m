//
//  GetSearchLoadResponse.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetSearchLoadResponse.h"

@implementation GetSearchLoadResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"baseSearchLoadModel":@"data"
             };
}

+(NSValueTransformer *)baseSearchLoadModelJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseSearchLoadModel class]];
}


@end
