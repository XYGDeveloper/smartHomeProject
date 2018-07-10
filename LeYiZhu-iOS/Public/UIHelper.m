//
//  UIHelper.m
//  Qqw
//
//  Created by zagger on 16/8/16.
//  Copyright © 2016年 gao.jian. All rights reserved.
//

#import "UIHelper.h"
#import "UIImage+Common.h"

@implementation UIHelper

#pragma mark - placeholder
+ (UIImage *)bigPlaceholder {
    return [UIImage imageNamed:@""];
}

+ (UIImage *)smallPlaceholder {
    return [UIImage imageNamed:@""];
}

#pragma mark - general button
+ (UIButton *)generalButtonWithTitle:(NSString *)title {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor greenColor]] forState:UIControlStateNormal];
    
    return btn;
}

+ (UIButton *)generalRaundCornerButtonWithTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:LYZTheme_paleBrown] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 2.0;
    btn.layer.masksToBounds = YES;
    
    return btn;
}

+ (UIButton *)appstyleBorderButtonWithTitle:(NSString *)title {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 2.0;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = [UIColor greenColor].CGColor;
    btn.layer.borderWidth = 1.0;
    
    return btn;
}

+ (UIButton *)grayBorderButtonWithTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 2.0;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 1.0;
    
    return btn;
}


#pragma mark - general label
+ (UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    return [self labelWithFont:font textColor:textColor textAlignment:NSTextAlignmentLeft];
}

+ (UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)alignment {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = alignment;
    
    return label;
}

@end
