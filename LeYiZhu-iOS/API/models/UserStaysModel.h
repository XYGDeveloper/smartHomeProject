//
//  UserStaysModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/22.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UserStaysModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *childOrderId;

@property (nonatomic, readonly, copy) NSString *orderID;

@property (nonatomic, readonly, copy) NSString *orderNO;

@property (nonatomic, readonly, strong) NSNumber *orderType;

@property (nonatomic, readonly, strong) NSNumber *status;

@property (nonatomic, readonly, strong) NSNumber *liveDays;

@property (nonatomic, readonly, copy) NSString *checkInDate;

@property (nonatomic, readonly, copy) NSString *checkOutDate;

@property (nonatomic, readonly, copy) NSString *hotelID;

@property (nonatomic, readonly, copy) NSString *hotelName;

@property (nonatomic, readonly, copy) NSString *address;

@property (nonatomic, readonly, copy) NSString *roomID;

@property (nonatomic, readonly, copy) NSString *roomTypeID;

@property (nonatomic, readonly, copy) NSString *roomType;

@property (nonatomic, readonly, copy) NSString *roomNum;

@property (nonatomic, readonly, copy) NSString *password;

@property (nonatomic, readonly, copy) NSString *longitude;

@property (nonatomic, readonly, copy) NSString *latitude;

@property (nonatomic, readonly, copy) NSString *lastcheckouttime;
@property (nonatomic, readonly, strong) NSNumber *remainDays;

@end
