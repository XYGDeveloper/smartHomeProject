//
//  GetCabinetInfoResponse.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/29.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetCabinetInfoResponse.h"
#import "CabinetInfoModel.h"

@implementation GetCabinetInfoResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"cabinetInfo":@"data"
             };
}

+(NSValueTransformer *)cabinetInfoJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CabinetInfoModel class]];
}

@end
