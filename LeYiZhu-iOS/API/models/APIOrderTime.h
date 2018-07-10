//
//  APIOrderTime.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/14.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface APIOrderTime : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, strong) NSNumber *status;

@property (nonatomic, readonly, copy) NSString *createTime;

@property (nonatomic, readonly, copy) NSString *payTime;

@property (nonatomic, readonly, copy) NSString *paperworkTime;

@property (nonatomic, readonly, copy) NSString *checkinTime;

@property (nonatomic, readonly, copy) NSString *checkoutTime;

@property (nonatomic, readonly, copy) NSString *cancelTime;

@property (nonatomic, readonly, copy) NSString *refundTime;

@property (nonatomic, readonly, copy) NSString *orderNO;

@end
