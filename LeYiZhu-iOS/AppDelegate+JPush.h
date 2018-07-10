//
//  AppDelegate+JPush.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/10/20.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"
#import "XFAlertView.h"
@interface AppDelegate (JPush)<JPUSHRegisterDelegate,XFAlertViewDelegate>

//初始化jpush
-(void)setupJpush:(nullable NSDictionary *)launchOptions;

@end
