//
//  UseLoginBycache.m
//  LeYiZhu-iOS
//
//  Created by L on 2017/3/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "UseLoginBycache.h"

@implementation UseLoginBycache
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"userInfo":@"data"
             };
}

+(NSValueTransformer *) userInfoJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[UserInfo class]];
}


@end
