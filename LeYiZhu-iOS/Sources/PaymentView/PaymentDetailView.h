//
//  PaymentDetailView.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/13.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CountMoneyModel,CountRefillLiveMoneyModel;

@interface PaymentDetailView : UIView

- (void)dismiss;

- (void)configureWithMoneyModel:(CountMoneyModel*)moneyModel;

- (void)configureWithRenewMoneyModel:(CountRefillLiveMoneyModel *)moneyModel;


@end
