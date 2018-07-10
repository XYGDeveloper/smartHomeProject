//
//  LYZHotelRoomDetailModel.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "LYZHotelRoomDetailModel.h"

@implementation LYZHotelRoomDetailModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"roomTypeID":@"roomTypeID",
             @"roomType":@"roomType",
             @"imgPath":@"imgPath",
             @"price":@"price",
             @"isWIFI":@"isWIFI",
             @"roomSize":@"roomSize",
             @"capacity":@"capacity",
             @"bedType":@"bedType",
             @"tips":@"tips",
             @"roomFloors":@"roomFloors",
             @"roomTypeImgs": @"roomTypeImgs",
             @"openstatus":@"openstatus",
             @"vipprice":@"vipprice",
             @"hotelid":@"hotelid",
             @"hotelname":@"hotelname",
             @"vipname":@"vipname",
             @"vipcode":@"vipcode"
             };
}


@end
