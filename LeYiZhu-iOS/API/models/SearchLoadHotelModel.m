//
//  SearchLoadHotelModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "SearchLoadHotelModel.h"

@implementation SearchLoadHotelModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"hotelID":@"id",
             @"name":@"name",
             @"distance":@"distance"
             };
}

@end
