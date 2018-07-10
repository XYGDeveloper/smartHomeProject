//
//  LYZHotelDetailModel.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "LYZHotelDetailModel.h"

@implementation LYZHotelDetailModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"hotelID":@"hotelID",
             @"hotelName":@"hotelName",
             @"address":@"address",
             @"facility":@"facility",
             @"lowestPrice":@"lowestPrice",
             @"checkInInfo":@"checkInInfo",
             @"introduction":@"introduction",
             @"distance":@"distance",
             @"commentCount":@"commentCount",
            @"avgSatisfaction":@"avgSatisfaction",
             @"hotelImgs":@"hotelImgs",
             @"roomTypes":@"roomTypes",
             @"comments":@"comments",
             @"isFavorite":@"isFavorite",
             @"longitude":@"longitude",
             @"latitude":@"latitude",
             @"status":@"status",
             @"tags":@"tags"
             };
}

+ (NSValueTransformer *)roomTypesJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[HotelRoomsModel class]];
}

+ (NSValueTransformer *)commentsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[HotelCommentsModel class]];
}

@end
