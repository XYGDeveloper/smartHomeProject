//
//  CommitRefillLiveOrderResponse.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "CommitRefillLiveOrderResponse.h"


@implementation CommitRefillLiveOrderResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"renewOrder":@"data"
             };
}

+(NSValueTransformer *)renewOrderJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CreateRenewModel class]];
}


@end
