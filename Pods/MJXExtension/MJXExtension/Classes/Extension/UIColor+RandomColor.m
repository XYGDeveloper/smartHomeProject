//
//  UIColor+RandomColor.m
//  demo14-AttachmentCollectionView
//
//  Created by 张鹏 on 13-9-27.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)

+ (UIColor *)randomColor {
    
    CGFloat red = (CGFloat)arc4random() / (CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)arc4random() / (CGFloat)RAND_MAX;
    CGFloat yellow = (CGFloat)arc4random() / (CGFloat)RAND_MAX;

    return [UIColor colorWithRed:red green:green blue:yellow alpha:1.0];
}

+ (UIColor *)specialRandomColor {
    
    CGFloat hue = arc4random() % 256 / 256.0 ;  //  0.0 to 1.0
    CGFloat saturation = arc4random() % 128 / 256.0 + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = arc4random() % 128 / 256.0 + 0.5;  //  0.5 to 1.0, away from black
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
