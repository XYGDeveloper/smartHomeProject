//
//  MineInfoResponse.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "MineInfoResponse.h"
#import "BaseMineInfoModel.h"


@implementation MineInfoResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"baseMineInfo":@"data"
             };
}

+(NSValueTransformer *)baseMineInfoJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseMineInfoModel class]];
}

@end
