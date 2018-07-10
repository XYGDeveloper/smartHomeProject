//
//  LYZCheckInViewController.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYZStayPlanViewController.h"

@class UserStaysModel;

@interface LYZCheckInViewController : UIViewController

@property (nonatomic, strong) UserStaysModel *dataSource;

@property (nonatomic, strong) NSArray *waitingDataSource;

@end
