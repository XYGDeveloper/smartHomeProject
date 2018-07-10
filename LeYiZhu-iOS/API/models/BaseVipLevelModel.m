//
//  BaseVipLevelModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "BaseVipLevelModel.h"
#import "VipLevelModel.h"

@implementation BaseVipLevelModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"exp":@"exp",
             @"vipcode":@"vipcode",
             @"vipRulesUrl":@"url",
             @"viplevels":@"viplevels"
             };
}

+(NSValueTransformer *)viplevelsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[VipLevelModel class]];
}


@end
