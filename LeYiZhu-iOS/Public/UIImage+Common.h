//
//  UIImage+Common.h
//  Zhuzhu
//
//  Created by zagger on 15/12/28.
//  Copyright © 2015年 www.globex.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Common)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageWithRoundedCornersSize:(float)cornerRadius usingImage:(UIImage *)original;

@end
