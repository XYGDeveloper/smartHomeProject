//
//  UIColor+RGBColor.m
//  BeiKePark
//
//  Created by 苏俊杰 on 16/8/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIColor+RGBColor.h"

@implementation UIColor (RGBColor)

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color
{
    return [self colorWithHexString:color alpha:1];
}

+ (UIColor *) colorWithHexString: (NSString *)color alpha:(CGFloat) alpha{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

+ (UIColor *)colorFromCycRGB:(NSString *)color;
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != color)
    {
        NSScanner *scanner = [NSScanner scannerWithString:color];
        (void) [scanner scanHexInt:&colorCode];
    }
    
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode);
    result = [UIColor colorWithRed:(float)redByte / 0xff
                             green:(float)greenByte / 0xff
                              blue:(float)blueByte / 0xff
                             alpha:1.0];
    return result;
}

+ (UIColor *)colorFromCycRGB:(NSString *)color alpha:(float)alpha;
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != color)
    {
        NSScanner *scanner = [NSScanner scannerWithString:color];
        (void) [scanner scanHexInt:&colorCode];
    }
    
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode);
    result = [UIColor colorWithRed:(float)redByte / 0xff
                             green:(float)greenByte / 0xff
                              blue:(float)blueByte / 0xff
                             alpha:alpha];
    return result;
}


@end
