//
//  OrderCheckInsModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/1/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface OrderCheckInsModel : MTLModel<MTLJSONSerializing>

@property (nonatomic ,readonly, copy) NSString *checkInDate;

@property (nonatomic ,readonly, copy) NSString *checkOutDate;

@property (nonatomic ,readonly, copy) NSString *continueDate;

@property (nonatomic ,readonly, copy) NSString *roomNum;

@property (nonatomic ,readonly, copy) NSString *liveUserName;

@property (nonatomic ,readonly, copy) NSString *liveUserPhone;

@property (nonatomic ,readonly, copy) NSString *liveUserId;

@property (nonatomic ,readonly, strong) NSNumber *liveDay;

@property (nonatomic ,readonly, copy) NSArray *roomPrice;

@property (nonatomic ,readonly, copy) NSString *roomPriceSum;

@property (nonatomic, readonly, copy) NSString *deposit;




@end
