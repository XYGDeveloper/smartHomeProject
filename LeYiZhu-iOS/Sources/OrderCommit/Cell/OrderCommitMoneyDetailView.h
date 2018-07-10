//
//  OrderCommitMoneyDetailView.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CountMoneyModel;

@interface OrderCommitMoneyDetailView : UIView

- (void)configureWithMoneyModel:(CountMoneyModel*)moneyModel;

@property (nonatomic, copy) void(^wxPay)();

@property (nonatomic,copy) void(^aliPay)();

@end
