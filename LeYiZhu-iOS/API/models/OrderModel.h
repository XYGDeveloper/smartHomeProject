//
//  OrderModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/1/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface OrderModel : MTLModel<MTLJSONSerializing>

@property (nonatomic ,readonly, copy) NSString *orderID;

@property (nonatomic ,readonly, copy) NSString *orderNO;

@property (nonatomic ,readonly, strong) NSNumber*orderType; //(0.游客订单1.普通订单 2.续住订单3.游客续住订单 3.补款单)

@property (nonatomic ,readonly, strong) NSNumber *hostStatus;//订单主状

@property (nonatomic ,readonly, strong) NSNumber *childStatus;//订单状态

@property (nonatomic ,readonly, strong) NSNumber *payNum;

@property (nonatomic ,readonly, copy) NSString *stayMoneySum;

@property (nonatomic ,readonly, copy) NSString *depositSum;

@property (nonatomic ,readonly, copy) NSString *actualPayment;

@property (nonatomic ,readonly, copy) NSString *deductible;

@property (nonatomic ,readonly, copy) NSString *phone;

@property (nonatomic, readonly, copy) NSString *checkInDate;

@property (nonatomic, readonly, copy) NSString *checkOutDate;

@property (nonatomic, readonly, copy) NSString *createTime;

@property (nonatomic ,readonly, copy) NSString *coupondenominat;

@property (nonatomic, readonly, copy) NSString *coupondetatilid;

@property (nonatomic, readonly, strong) NSNumber *coupontype;

@property (nonatomic, readonly, copy) NSString *coupondiscount;

@property (nonatomic, readonly, copy) NSString *returnAmount;
//
@property (nonatomic, readonly, copy) NSString *customerServiceDiscount;

@property (nonatomic, readonly, copy) NSString *paid;

@property (nonatomic, readonly, copy) NSString *deduction;

@property (nonatomic, readonly, copy) NSString *isCancel;
@property (nonatomic, readonly, copy) NSString *totalDiscount;


@end
