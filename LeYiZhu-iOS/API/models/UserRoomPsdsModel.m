//
//  UserRoomPsdsModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/14.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "UserRoomPsdsModel.h"

@implementation UserRoomPsdsModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"hotelRoomPwdID":@"hotelRoomPwdID",
             @"hotelName":@"hotelName",
             @"orderID":@"orderID",
             @"hotelRoomNum":@"hotelRoomNum",
             @"hotelRoomNumID":@"hotelRoomNumID",
             @"password":@"password",
             @"startDate":@"startDate",
             @"endDate":@"endDate"
             };
}

@end
