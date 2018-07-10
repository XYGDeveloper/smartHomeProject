//
//  UIViewController+Extension.h
//  基础框架
//
//  Created by MJX on 2017/7/5.
//  Copyright © 2017年 ShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

//MARK: -- 隐藏导航栏
- (void)hiddenNavigationBar;

//MARK: -- 显示导航栏
- (void)showNavigationBar;

//MARK: -- 隐藏标签栏
- (void)hiddenTabBar;

//MARK: -- 显示标签栏
- (void)showTabBar;


//MARK: -- 设置标题
- (void)setNavigationBarTitle: (NSString *)text;

//MARK: -- 设置返回按钮
- (void)setBackImageWithName:(NSString *)name;

//MARK: -- 设置右侧自定义图(包括按钮)
- (void)setRightView:(UIView *)customView;

//MARK: -- 设置左侧自定义图(包括按钮)
- (void)setLeftView:(UIView *)customView;

//MARK: -- 设置右侧Items
- (void)setRightWithItems:(NSArray <UIBarButtonItem *>*)items;

@end
