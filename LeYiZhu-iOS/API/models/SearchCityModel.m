//
//  SearchCityModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2016/12/14.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "SearchCityModel.h"

@implementation SearchCityModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"hotelID":@"hotelID",
             @"hotelName":@"hotelName",
             @"cityID":@"cityID",
             @"cityName":@"cityName",
             @"type":@"type"
             };
}

@end
