//
//  UserLoginResponse.m
//  NexPack
//
//  Created by levo on 15/9/15.
//  Copyright (c) 2015年 noa-labs. All rights reserved.
//

#import "UserLoginResponse.h"


@implementation UserLoginResponse

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
