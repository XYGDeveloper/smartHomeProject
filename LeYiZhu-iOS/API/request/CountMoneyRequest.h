//
//  CountMoneyRequest.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "IRequest.h"

@interface CountMoneyRequest : AbstractRequest

@property (nonatomic, copy) NSString *roomTypeID;

@property (nonatomic, copy) NSString *payNum;

@property (nonatomic, copy) NSString *checkInDate;

@property (nonatomic, copy) NSString *checkOutDate;

@property (nonatomic, copy) NSString *coupondetatilid;

@end
