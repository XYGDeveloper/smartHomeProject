//
//  UIStoryboard+Extension.h
//  Enterprise
//
//  Created by SG on 2017/3/31.
//  Copyright © 2017年 com.sofn.lky.enterprise. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (Extension)

//Storyboard
+ (instancetype)SBWithName:(NSString *)name;

//Storyboard的根视图控制器
+ (UIViewController *)rootViewControllerWithSBName:(NSString *)name;

//name的Storyboard中的identifier的神力控制器
+ (UIViewController *)viewControllerWithSBName:(NSString *)name identifier:(NSString *)identifier;

//切换Windows的根控制器成name为Storyboard的根视图控制器
+ (void)swithWindowsRootViewControllerWithSBName:(NSString *)name;

@end
