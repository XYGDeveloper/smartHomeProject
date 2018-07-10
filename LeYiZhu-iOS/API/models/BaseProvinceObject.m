//
//  BaseProvinceObject.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/1.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "BaseProvinceObject.h"
#import "ProvinceModel.h"

@implementation BaseProvinceObject

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"provinceslist":@"provinces"
            };
}

+ (NSValueTransformer *)provinceslistJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[ProvinceModel class]];
}

@end

