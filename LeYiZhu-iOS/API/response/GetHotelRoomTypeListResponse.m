//
//  GetHotelRoomTypeListResponse.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetHotelRoomTypeListResponse.h"
#import "HotelRoomsModel.h"

@implementation GetHotelRoomTypeListResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"baseHotelRooms":@"data"
             };
}

+(NSValueTransformer *)baseHotelRoomsJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseHotelRoomsModel class]];
}

@end
