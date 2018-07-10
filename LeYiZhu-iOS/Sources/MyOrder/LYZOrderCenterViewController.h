//
//  LYZOrderCenterViewController.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/1.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    waitingPayStatus = 0,//待支付
    payAlreadyStatus,//已支付
    checkInStatus,//已入住
    compeleteStatus,//已完成
    allOrderStatus //全部订单
} orderStatus;

@class BaseLYZOrders;
@interface LYZOrderCenterViewController : UIViewController

@property  (nonatomic, assign) orderStatus status;
@property (nonatomic, copy) NSString *orderTitle;

-(void)orderBtnClicked:(BaseLYZOrders *)status;

@end
