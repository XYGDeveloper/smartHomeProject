//
//  SearchHotelModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/25.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "SearchHotelModel.h"
#import "SearchLoadHotelModel.h"

@implementation SearchHotelModel


+(instancetype)initWithHotel:(SearchLoadHotelModel *)hotel{
    SearchHotelModel *searchHotel= [[SearchHotelModel alloc] init];
    searchHotel.hotelID = hotel.hotelID;
    searchHotel.name = hotel.name;
    searchHotel.distance = hotel.distance;
    return searchHotel;
}


@end
