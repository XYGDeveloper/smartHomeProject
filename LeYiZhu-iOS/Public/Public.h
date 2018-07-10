//
//  Public.h
//  ZTE_Health
//
//  Created by mac on 16/3/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "BaseNavController.h"


@interface Public : NSObject

+ (MBProgressHUD*)showHudWithTitle:(UIView*)baseView message:(NSString*)message;

+ (void)changeRootViewControllerToMainVC;

+ (UIViewController*)initControllerFromStoryBoard:(NSString*)storyboard  identifier:(NSString*)identifier;

//用HUD显示Message 用completeBlock
+ (void)showMessageWithHUD:(UIView *)baseView message:(NSString *)message completeBlock:(MBProgressHUDCompletionBlock)block;
//用HUD显示message
+ (void)showMessageWithHUD:(UIView*)baseView message:(NSString*)message;
//用系统自带的alertView显示message
+ (void)showAlertWithMessage:(NSString *)message;
//不屏蔽的请求
+ (void)showMessageGlobalHud:(UIView*)baseView message:(NSString *)message;
//弹出警告对话框
+ (void)showAlertWithTitle:(NSString *)title  message:(NSString *)message;


+ (MBProgressHUD *)showHUD:(UIView *)view;



//获取全局代理
+ (AppDelegate*)getAppDelegate;

/*
//获取全局的BaseNav
+ (BaseNavController *)getGlobalBaseNav;
*/

/*

+ (UIImage *)fetchDeviceImageDefault;

//通过关系获取头像
+ (UIImage *)fetchGuanXiImageFromGuanXi:(NSInteger)guanxi;

//通过性别获取头像
+ (UIImage *)fetchGuanXiImageFromSex:(NSInteger)sex;

//在数据库中获取图片
+ (UIImage *)fetchImageFromLocalDB:(NSString *)key;

+(NSString *)isNullAndSetSpacs:(NSString *)str;

 */
+ (UIImage *)buttonImageFromColor:(UIColor *)color;

@end
