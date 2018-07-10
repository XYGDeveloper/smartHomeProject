//
//  GetVIPLevelListResponse.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetVIPLevelListResponse.h"
#import "BaseVipLevelModel.h"

@implementation GetVIPLevelListResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"baseVipLevel":@"data"
             };
}

+(NSValueTransformer *)baseVipLevelJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseVipLevelModel class]];
}


@end
