//
//  HotelSearchResultModel.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/1.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "HotelSearchResultModel.h"

@implementation HotelSearchResultModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"hotelID":@"hotelID",
             @"hotelName":@"hotelName",
             @"address":@"address",
             @"lowestPrice":@"lowestPrice",
             @"distance":@"distance",
             @"imgPath":@"imgPath",
             @"type":@"type",
             @"avgSatisfaction":@"avgSatisfaction"
             };
}


@end
