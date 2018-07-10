//
//  UIButton+Extension.h
//  基础框架
//
//  Created by MJX on 2017/7/5.
//  Copyright © 2017年 ShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/*
 *设置Normal和Seleted时不同的显示标题和图片等
 */

// MARK: -- 设置标题
- (void)setNormalTitle:(NSString *)normalTitle selectedTitile:(NSString *)selectedTitle;

// MARK: -- 设置颜色
- (void)setNormalTitleColor:(UIColor *)normalTitleColor selectedTitileColor:(UIColor *)selectedTitleColor;

// MARK: -- 设置图片
- (void)setNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage;

// MARK: -- 设置是否切换
- (void)setSwithStatus;


@end
