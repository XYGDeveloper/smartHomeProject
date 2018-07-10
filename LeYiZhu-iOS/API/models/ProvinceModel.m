//
//  ProvinceModel.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/11/30.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "ProvinceModel.h"
#import "CitysModel.h"



@implementation ProvinceModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"province_id":@"province_id",
             @"province_name":@"province_name",
             @"province_code":@"province_bianma",
             @"citys":@"citys"
             };
}

+(NSValueTransformer *)citysJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass: [CitysModel class]];
}

@end
