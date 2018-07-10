//
//  OrderHotelModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/1/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface OrderHotelModel : MTLModel<MTLJSONSerializing>

@property (nonatomic ,readonly, copy) NSString *hotelID;

@property (nonatomic ,readonly, copy) NSString *hotelName;

@property (nonatomic, readonly, copy) NSString *address;

@property (nonatomic, readonly, copy) NSString *longitude;

@property (nonatomic, readonly, copy) NSString *latitude;

@property (nonatomic ,readonly, copy) NSString *roomTypeID;

@property (nonatomic ,readonly, copy) NSString *roomType;

@property (nonatomic ,readonly, copy) NSString *roomSize;

@property (nonatomic ,readonly, copy) NSString *netType;

@property (nonatomic ,readonly, copy) NSString *bedType;

@property (nonatomic ,readonly, copy) NSString *roomTypeImg;

@property (nonatomic ,readonly, strong) NSArray *unitPrice;





@end
