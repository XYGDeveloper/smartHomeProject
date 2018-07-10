//
//  GetUserRoomPswListResponse.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/14.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "GetUserRoomPswListResponse.h"

@implementation GetUserRoomPswListResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"basePsds":@"data"
             };
}

+(NSValueTransformer *)basePsdsJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseRoomPsdsModel class]];
}

@end
