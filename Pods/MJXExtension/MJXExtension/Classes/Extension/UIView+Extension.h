//
//  UIView+Extension.h
//  基础框架
//
//  Created by MJX on 2017/7/3.
//  Copyright © 2017年 ShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

#pragma mark -- 添加圆角
@property (nonatomic) CGFloat left;       //返回 frame.origin.x
@property (nonatomic) CGFloat top;        //返回 frame.origin.y
@property (nonatomic) CGFloat right;      //返回 frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;     //返回 frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;      //返回 frame.size.width.
@property (nonatomic) CGFloat height;     //返回 frame.size.height.
@property (nonatomic) CGFloat centerX;    //返回 center.x
@property (nonatomic) CGFloat centerY;    //返回 center.y
@property (nonatomic) CGPoint origin;     //返回 frame.origin
@property (nonatomic) CGSize  size;       //返回 frame.size


/**
 *  添加圆角
 *  @param radius 修圆的弧度数
 */
- (void)setlayerRadiusWithAngle:(CGFloat)radius;

/**
 *  自定义Button
 *
 *  @param title     文字
 *  @param imageName 图片名
 */
- (void)setCustomButton:(NSString *)title image:(NSString *)imageName;


/**
 *  设置layer边框
 *
 *  @param radius 角
 *  @param width  宽度
 *  @param color  颜色
 */
- (void)setlayerCornerRadius:(CGFloat)radius
                borderWidth :(CGFloat)width
                borderColor :(UIColor *)color;

@end



