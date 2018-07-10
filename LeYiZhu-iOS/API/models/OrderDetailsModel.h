//
//  OrderDetailsModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface OrderDetailsModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly ,copy) NSString *orderID;
@property (nonatomic, readonly ,copy) NSString *orderNO;
@property (nonatomic, readonly, assign) NSNumber *orderType;
@property (nonatomic, readonly ,assign) NSNumber *status;
@property (nonatomic, readonly, copy) NSString *payTime;
@property (nonatomic, readonly ,copy) NSString *phone;
@property (nonatomic, readonly ,assign) NSNumber *liveDays;
@property (nonatomic, readonly, copy) NSString *createTime;
@property (nonatomic, readonly ,assign) NSNumber *payNum;
@property (nonatomic, readonly, copy) NSString *checkinTime;
@property (nonatomic, readonly, copy) NSString *checkoutTime;
@property (nonatomic, readonly, copy) NSString *paperworkTime;
@property (nonatomic, readonly ,copy) NSString *deductible; //优惠券折扣
@property (nonatomic, readonly, assign) NSNumber *actualPayment;
@property (nonatomic, readonly, copy) NSString *checkTime;
@property (nonatomic, readonly, copy) NSString *outTime;
@property (nonatomic, readonly, copy) NSString *hotelRoomID;
@property (nonatomic, readonly, copy) NSString *roomType;
@property (nonatomic, readonly, assign) NSNumber *deposit;
@property (nonatomic, readonly ,copy) NSString *roomSize;
@property (nonatomic, readonly ,copy) NSString *bedType;
@property (nonatomic, readonly ,copy) NSString *wifiType;
@property (nonatomic, readonly ,copy) NSString *roomIntroduction;
@property (nonatomic, readonly ,copy) NSString *hotelID;
@property (nonatomic, readonly ,copy) NSString *hotelName;
@property (nonatomic, readonly ,copy) NSString *address;
@property (nonatomic, readonly ,copy) NSString *longitude;
@property (nonatomic, readonly ,copy) NSString *latitude;
@property (nonatomic, readonly ,copy) NSString *sum;
@property (nonatomic , readonly, assign)NSNumber * postage;
@property (nonatomic , readonly, assign) NSNumber *invoicesType;
@property (nonatomic , readonly, copy) NSString *invoiceDetails;
@property (nonatomic , readonly, copy) NSString *invoiceLookup;
@property (nonatomic , readonly, copy) NSString *invoicesAddress;
@property (nonatomic , readonly, copy) NSString *recipient;
@property (nonatomic , readonly, copy) NSString *invoicePhone;
@property (nonatomic , readonly, copy) NSString *mailType;
@property (nonatomic , readonly, strong) NSArray *checkIns;
@property (nonatomic, readonly, strong) NSArray *userRoomPwds;
@property (nonatomic, readonly, strong) NSString *cancelTime;




@end
