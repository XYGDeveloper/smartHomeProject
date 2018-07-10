//
//  UIView+Extension.m
//  基础框架
//
//  Created by MJX on 2017/7/3.
//  Copyright © 2017年 ShangTong. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)


#pragma mark -- 属性值
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGFloat)left {
    return self.frame.origin.x;
}
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)top {
    return self.frame.origin.y;
}
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)centerX {
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}
- (CGFloat)centerY {
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}
- (CGPoint)origin {
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGSize)size {
    return self.frame.size;
}


#pragma mark -- 添加圆角
- (void)setlayerRadiusWithAngle:(CGFloat)radius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

- (void)setCustomButton:(NSString *)title image:(NSString *)imageName{
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(5, 0, self.width - 10, self.width -10);
    imageView.image = [UIImage imageNamed:imageName];
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, imageView.bottom + 10, self.width - 20, self.height - self.width + 15);
    label.numberOfLines = 0;
    label.text = title;
    label.textColor = [UIColor colorWithRed:51 green:51 blue:51 alpha:1];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
}

- (void)setlayerCornerRadius:(CGFloat)radius
                 borderWidth :(CGFloat)width
                 borderColor :(UIColor *)color{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}


@end


