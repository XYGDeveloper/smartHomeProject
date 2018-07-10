//
//  HotelRoomsModel.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "HotelRoomsModel.h"

@implementation HotelRoomsModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"roomTypeID":@"roomTypeID",
             @"roomType":@"roomType",
             @"imgPath":@"imgPath",
             @"price":@"price",
             @"roomSize":@"roomSize",
             @"bedType":@"bedType",
             @"capacity":@"capacity",
             @"isWIFI":@"isWIFI",
             @"validRoomSize":@"validRoomSize",
             @"openstatus":@"openstatus",
             @"vipprice":@"vipprice",
             @"roomTypeStatus":@"roomTypeStatus",
             @"prompt":@"prompt"
             };
}

@end
