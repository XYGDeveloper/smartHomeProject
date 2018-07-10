//
//  LYZRenewViewController.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYZRefillGuestInfoModel;
@interface LYZRenewViewController : UIViewController

@property (nonatomic, copy) NSString *roomTypeID;

@property (nonatomic ,copy) NSString *orderNo;
@property (nonatomic, copy) NSString *orderType;

-(void)needInvoice:(BOOL)need;

-(void)renewBtnSelect:(NSInteger ) index;

- (void)weixinPay:(BOOL)isSuccess;

- (void)zhifubaoPay:(BOOL)isSuccess;

-(void)datePick:(NSInteger) index;

-(void)trackSwitch:(BOOL)isOn;

-(void)chooseCoupon;

@end
