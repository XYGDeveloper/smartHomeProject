//
//  LYZRenewPayMoneyDetailView.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/4/17.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CountRefillLiveMoneyModel,BaseOrderDetailModel;
@interface LYZRenewPayMoneyDetailView : UIView

- (void)configureWithMoneyModel:(CountRefillLiveMoneyModel*)moneyModel;

- (void)configureWithLocalMoneyModel:(BaseOrderDetailModel*)moneyModel;

@property (nonatomic, copy) void(^wxPay)();

@property (nonatomic,copy) void(^aliPay)();

@end
