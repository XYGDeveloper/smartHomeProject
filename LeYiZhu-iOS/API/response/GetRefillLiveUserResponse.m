//
//  GetRefillLiveUserResponse.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetRefillLiveUserResponse.h"
#import "BaseRefillInfoModel.h"

@implementation GetRefillLiveUserResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"baseRefillModel":@"data"
             };
}

+(NSValueTransformer *) baseRefillModelJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseRefillInfoModel class]];
}

@end
