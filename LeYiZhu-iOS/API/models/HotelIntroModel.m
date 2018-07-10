//
//  HotelIntroModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/5.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "HotelIntroModel.h"

@implementation HotelIntroModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"hotelID":@"hotelID",
             @"hotelName":@"hotelName",
             @"intro":@"intro",
             @"tags":@"tags",
             @"facility":@"facility",
             @"checkInInfo":@"checkInInfo"
             };
}

@end
