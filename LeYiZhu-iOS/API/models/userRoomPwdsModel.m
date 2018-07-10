//
//  userRoomPwdsModel.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/1/17.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "userRoomPwdsModel.h"

@implementation userRoomPwdsModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"hotelRoomPwdID":@"hotelRoomPwdID",
             @"hotelRoomNumID":@"hotelRoomNumID",
             @"password":@"password",
             @"startDate":@"startDate",
             @"endDate":@"endDate",
             @"roomNum":@"roomNum"
             };
}



@end
