//
//  GetCityDataResponse.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/11/30.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "GetCityDataResponse.h"

@implementation GetCityDataResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"provicesObject":@"data"
             };
}

+ (NSValueTransformer *)provicesObjectJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseProvinceObject class]];
}
@end
