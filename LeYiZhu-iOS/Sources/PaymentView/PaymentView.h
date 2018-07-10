//
//  PaymentView.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CountMoneyModel,CountRefillLiveMoneyModel,BaseOrderDetailModel;

@interface PaymentView : UIView

- (void)configureWithMoneyModel:(CountMoneyModel*)moneyModel hotelName:(NSString *)hotelName roomType:(NSString *)roomType;

- (void)configureWithRenewMoneyModel:(CountRefillLiveMoneyModel *)moneyModel hotelName:(NSString *)hotelName roomType:(NSString *)roomType;

- (void)configureWithLocalMoneyModel:(BaseOrderDetailModel *)moneyModel;

@property (nonatomic, copy) void(^wxPay)();

@property (nonatomic,copy) void(^aliPay)();

@end
