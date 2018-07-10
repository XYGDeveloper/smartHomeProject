//
//  OrderHotelModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/1/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "OrderHotelModel.h"
#import "RoomPriceModel.h"

@implementation OrderHotelModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"hotelID":@"hotelID",
              @"hotelName":@"hotelName",
             @"address":@"address",
             @"longitude":@"longitude",
             @"latitude":@"latitude",
             @"roomTypeID":@"roomTypeID",
             @"roomType":@"roomType",
             @"roomSize":@"roomSize",
             @"bedType":@"bedType",
             @"netType":@"netType",
             @"roomTypeImg":@"roomTypeImg",
             @"unitPrice":@"unitPrice"
             };
}

+ (NSValueTransformer *)unitPriceJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[RoomPriceModel class]];
}

@end
