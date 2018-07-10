//
//  BaseHotelRoomsModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "BaseHotelRoomsModel.h"
#import "HotelRoomsModel.h"

@implementation BaseHotelRoomsModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"roomTypes":@"roomTypes"
             };
}

+(NSValueTransformer *)roomTypesJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[HotelRoomsModel class]];
}


@end
