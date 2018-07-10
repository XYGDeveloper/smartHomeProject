//
//  BaseRoomPsdsModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/14.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "BaseRoomPsdsModel.h"
#import "UserRoomPsdsModel.h"

@implementation BaseRoomPsdsModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"userRoomPwds":@"userRoomPwds"
             };
}

+ (NSValueTransformer *)userRoomPwdsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[UserRoomPsdsModel class]];
}


@end
