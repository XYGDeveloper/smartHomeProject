//
//  LYZWaitingCheckInViewController.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYZStayPlanViewController.h"

@class UserStaysModel;
@interface LYZWaitingCheckInViewController : UIViewController

@property (nonatomic, assign)BOOL canDisMiss;
- (void)showInViewController:(UIViewController *)vc;




@end
