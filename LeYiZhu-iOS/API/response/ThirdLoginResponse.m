//
//  ThirdLoginResponse.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "ThirdLoginResponse.h"

@implementation ThirdLoginResponse

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
