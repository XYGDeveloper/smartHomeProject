//
//  UserStaysModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/22.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "UserStaysModel.h"

@implementation UserStaysModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"childOrderId":@"childOrderId",
             @"orderType":@"orderType",
             @"orderNO":@"orderNO",
             @"status":@"status",
             @"liveDays":@"liveDays",
             @"checkInDate":@"checkInDate",
             @"checkOutDate":@"checkOutDate",
             @"hotelID":@"hotelID",
             @"hotelName":@"hotelName",
             @"address":@"address",
             @"roomTypeID":@"roomTypeID",
             @"roomType":@"roomType",
             @"roomID":@"roomID",
             @"roomNum":@"roomNum",
             @"password":@"password",
             @"longitude":@"longitude",
             @"latitude":@"latitude",
             @"remainDays":@"remainDays"
             };
}


@end
