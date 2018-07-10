//
//  UIImage+Extension.h
//  基础框架
//
//  Created by MJX on 2017/7/5.
//  Copyright © 2017年 ShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  设置一个纯色大小的图片
 *  @param color  颜色
 *  @param size 大小
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
