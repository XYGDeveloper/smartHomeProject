//
//  UIButton+Extension.m
//  基础框架
//
//  Created by MJX on 2017/7/5.
//  Copyright © 2017年 ShangTong. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

// MARK: -- 设置标题
- (void)setNormalTitle:(NSString *)normalTitle selectedTitile:(NSString *)selectedTitle{
    if (normalTitle) {
        [self setTitle:normalTitle forState:UIControlStateNormal];
    }
    if (selectedTitle) {
        [self setTitle:selectedTitle forState:UIControlStateSelected];
    }
    
}

// MARK: -- 设置颜色
- (void)setNormalTitleColor:(UIColor *)normalTitleColor selectedTitileColor:(UIColor *)selectedTitleColor{
    
    if (normalTitleColor) {
        [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
    }
    if (selectedTitleColor) {
        [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
        
    }
}

// MARK: -- 设置图片
- (void)setNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage{
    if (normalImage) {
        [self setImage:normalImage forState:UIControlStateNormal];
    }
    if (selectedImage) {
        [self setImage:selectedImage forState:UIControlStateSelected];
    }
}

// MARK: -- 设置是否切换
- (void)setSwithStatus{
    self.selected = !self.selected;
}

@end
