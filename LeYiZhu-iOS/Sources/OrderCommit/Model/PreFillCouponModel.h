//
//  PreFillCouponModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PreFillCouponModel : NSObject


@property (nonatomic, copy) NSString *coupondetatilid;

@property (nonatomic, copy) NSString *coupondenominat;

@property (nonatomic, copy) NSString *coupondiscount;

@property (nonatomic, assign) NSNumber *coupontype;//(0.无优惠券1.现金券 2.折扣券 4.不使用优惠券)

@property (nonatomic, copy) NSString *couponName;

@end
