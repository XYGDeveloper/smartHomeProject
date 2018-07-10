//
//  LYZOrderCommitViewController.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/2.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "BaseController.h"
@class LYZOrderCommitRoomInfoModel,LYZOrderGuestInfoModel;

@interface LYZOrderCommitViewController : BaseController

#pragma mark-外部参数
//@property (nonatomic,strong)NSString *lat;
//@property (nonatomic,strong)NSString *lon;
//@property (nonatomic,strong)NSString *address;

@property (nonatomic, strong) NSDate *checkInDate;
@property (nonatomic, strong) NSDate *checkOutDate;
@property (nonatomic, copy) NSString *roomTypeID;

@property (nonatomic,strong) NSString *fromOrderNO;//订单详情传过来的值。用于续住
@property (nonatomic,strong) NSString *fromOrderType;//同上

-(void)addGuest:(NSInteger)index;

-(void)needInvoice:(BOOL)need;

-(void)selectDate:(BOOL)isCheckIn;

-(void)chooseRoomCount;

-(void)chooseGuest:(NSInteger)index;

-(void)toInvoiceDetail;

- (void)weixinPay:(BOOL)isSuccess;

- (void)zhifubaoPay:(BOOL)isSuccess;

-(void)chooseLocalContact;

-(void)trackSwitch:(BOOL)isOn;

-(void)chooseCoupon;

@end
