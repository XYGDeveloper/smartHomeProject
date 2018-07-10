//
//  CommitRefillLiveOrderRequest.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "IRequest.h"

@interface CommitRefillLiveOrderRequest : AbstractRequest


@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *invoiceType;

@property (nonatomic, strong) NSDictionary *invoiceInfo;

@property (nonatomic, strong) NSArray *childOrderIds;

@property (nonatomic, copy) NSString *isOpenPrivacy;

@property (nonatomic, copy) NSString *coupondetatilid;









@end
