//
//  BaseMineInfoModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "BaseMineInfoModel.h"
#import "VipInfoModel.h"

@implementation BaseMineInfoModel


+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"username":@"username",
             @"isvip":@"isvip",
             @"vipinfo":@"vipinfo",
             @"todopaycount":@"todopaycount",
             @"todocheckincount":@"todocheckincount",
             @"couponcount":@"couponcount",
             @"favoritecount":@"favoritecount",
             @"phone":@"phone",
             @"facepath":@"facepath",
             @"invitecode":@"invitecode",
             @"contactsSize":@"contactsSize",
             @"points":@"points",
             @"isSign":@"isSign"
             };
}

+(NSValueTransformer *)vipinfoJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[VipInfoModel class]];
}

@end
