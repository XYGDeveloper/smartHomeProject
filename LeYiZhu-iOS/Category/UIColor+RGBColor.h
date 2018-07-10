//
//  UIColor+RGBColor.h
//  BeiKePark
//
//  Created by 苏俊杰 on 16/8/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RGBColor)

/**需要写#号*/
+ (UIColor *) colorWithHexString: (NSString *)color;
+ (UIColor *) colorWithHexString: (NSString *)color alpha:(CGFloat) alpha;
/**不需要写#号*/
+ (UIColor *)colorFromCycRGB:(NSString *)color;
+ (UIColor *)colorFromCycRGB:(NSString *)color alpha:(float)alpha;

@end
