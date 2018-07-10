//
//  VipCardLevelViewController.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/8.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VipCardMacros.h"


@interface VipCardLevelViewController : UIViewController

@property (nonatomic, assign) vipType currentVipType;

@property (nonatomic, strong) NSNumber *currentGrowingValue;//成长值

@end
