//
//  CouponModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/9.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CouponModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *couponID;

@property (nonatomic, readonly, assign) NSNumber *coupontype;//优惠券类型(1.现金券 2.折扣券)

@property (nonatomic, readonly, copy) NSString *denominat;//面额

@property (nonatomic, readonly, copy) NSString *discount;//折扣率

@property (nonatomic, readonly, copy) NSString *couponDesc;//简介

@property (nonatomic, readonly, copy) NSString *starttime;

@property (nonatomic, readonly, copy) NSString *endtime;

@property (nonatomic, readonly, strong) NSNumber *status;//状态(2.已领取 3.已锁定 4.已使用 5.已过期)

@property (nonatomic, readonly, copy) NSString *range;

@property (nonatomic, readonly, assign) NSNumber *checkrange;//限用入住范围(1.通用 2.过夜房 3.钟点房)

@property (nonatomic, readonly, copy) NSString *isavailable;//是否可用(Y.是 N.否)

@property (nonatomic, readonly, copy) NSString *remark;//使用说明

@property (nonatomic, readonly, copy) NSString *name;//优惠券名字









@end
