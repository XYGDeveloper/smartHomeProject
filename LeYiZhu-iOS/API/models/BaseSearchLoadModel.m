//
//  BaseSearchLoadModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "BaseSearchLoadModel.h"
#import "SearchLoadCitysModel.h"
#import "SearchLoadHotelModel.h"

@implementation BaseSearchLoadModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"hotels":@"hotels",
             @"citys":@"citys",
             };
}

+(NSValueTransformer *)hotelsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[SearchLoadHotelModel class]];
}


+(NSValueTransformer *)citysJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[SearchLoadCitysModel class]];
}


@end
