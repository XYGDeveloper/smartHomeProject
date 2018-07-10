//
//  GetHotelRoomDetailsResponse.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "GetHotelRoomDetailsResponse.h"

@implementation GetHotelRoomDetailsResponse



+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"hotelRoomDetail":@"data"
             };
}

+ (NSValueTransformer *)hotelRoomDetailJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[LYZHotelRoomDetailModel class]];
}

@end
