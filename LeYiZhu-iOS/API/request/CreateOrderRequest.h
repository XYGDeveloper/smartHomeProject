//
//  CreateOrderRequest.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/7.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "IRequest.h"

@interface CreateOrderRequest : AbstractRequest


@property (nonatomic, copy) NSString *roomTypeID;

@property (nonatomic, copy) NSString *checkInDate;

@property (nonatomic, copy) NSString *checkOutDate;

@property (nonatomic, copy) NSString *payNum;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, strong) NSArray *checkIns;

@property (nonatomic, copy) NSString *invoiceType;

@property (nonatomic, strong) NSDictionary *invoiceInfo;

@property (nonatomic, copy) NSString *isOpenPrivacy;

@property (nonatomic, copy) NSString *coupondetatilid;


@end
