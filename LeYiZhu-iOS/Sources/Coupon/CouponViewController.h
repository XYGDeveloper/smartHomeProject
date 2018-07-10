//
//  CouponViewController.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/28.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CouponModel;
@interface CouponViewController : UIViewController

@property (nonatomic, copy) NSString *price; // 如果有价钱，表示使用优惠券，为nil 表示展示优惠券
@property (nonatomic, copy)void (^couponCallBack)(id coupon);

-(void)announcement:(CouponModel *)model;

@end
