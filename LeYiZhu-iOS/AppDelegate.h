//
//  AppDelegate.h
//  LeYiZhu-iOS
//
//  Created by a a  on 2016/11/18.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginController.h"
#import "LYZOrderCommitViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "BaseTabBarController.h"
#import "BaseNavController.h"
#import "LYZOrderFormViewController.h"
#import "LYZRenewViewController.h"

//test
#import "HYNewFeatureCtr.h"
//#define OpenIndicator 1

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic , weak) LoginController *loginVC;

@property (nonatomic , weak) LYZOrderCommitViewController *orderDetailVC;

@property (nonatomic, weak)LYZOrderFormViewController *orderFormVC;

@property (nonatomic, weak) LYZRenewViewController *renewOrderVC;

@property (nonatomic , strong) TencentOAuth *tencentOAuth;

@property (nonatomic , strong) BaseTabBarController *rootTab;

- (void)changeToMainVC;

//test

@property (nonatomic, strong) UILabel *indicatorLabel;

@end

