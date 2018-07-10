//
//  LYZOrderFormViewController.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYZOrderFormViewController : UIViewController

@property (nonatomic,strong) NSString *orderNo;

@property (nonatomic, strong) NSString *orderType;

@property (nonatomic, assign) BOOL payNow;

- (void)weixinPay:(BOOL)isSuccess;

- (void)zhifubaoPay:(BOOL)isSuccess;

-(void)cancelOrder:(NSString *)orderNo orderType:(NSString *)orderType;

-(void)showPaymentDetail;



@end
