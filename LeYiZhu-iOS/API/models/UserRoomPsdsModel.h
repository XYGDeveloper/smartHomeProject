//
//  UserRoomPsdsModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/14.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UserRoomPsdsModel : MTLModel<MTLJSONSerializing>

@property (nonatomic ,readonly, copy) NSString *hotelRoomPwdID;

@property (nonatomic, readonly, copy) NSString *hotelName;

@property (nonatomic, readonly, copy) NSString *orderID;

@property (nonatomic ,readonly, copy) NSString *hotelRoomNum;

@property (nonatomic, readonly, copy) NSString *hotelRoomNumID;

@property (nonatomic, readonly, copy) NSString *password;

@property (nonatomic ,readonly, copy) NSString *startDate;

@property (nonatomic, readonly, copy) NSString *endDate;


@end
