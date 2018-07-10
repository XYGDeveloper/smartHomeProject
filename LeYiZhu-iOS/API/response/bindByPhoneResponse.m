//
//  bindByPhoneResponse.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/29.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "bindByPhoneResponse.h"
#import "UserInfo.h"

@implementation bindByPhoneResponse

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
