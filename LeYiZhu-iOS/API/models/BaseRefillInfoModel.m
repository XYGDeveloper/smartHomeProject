//
//  BaseRefillInfoModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "BaseRefillInfoModel.h"
#import "RefillInfoModel.h"

@implementation BaseRefillInfoModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"childOrderInfoJar":@"childOrderInfoJar",
             @"hotelJson":@"hotelJson",
             @"userPhone":@"userPhone",
             @"coupondetatilid":@"coupondetatilid",
             @"coupontype":@"coupontype",
             @"coupondenominat":@"coupondenominat",
             @"coupondiscount":@"coupondiscount"
             };
}

+(NSValueTransformer *)childOrderInfoJarJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[ RefillInfoModel class]];
}

+(NSValueTransformer *)hotelJsonJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ OrderHotelModel class]];
}

@end
