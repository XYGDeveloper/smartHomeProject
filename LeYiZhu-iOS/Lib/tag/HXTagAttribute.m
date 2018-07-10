//
//  HXTagAttribute.m
//  HXTagsView https://github.com/huangxuan518/HXTagsView
//  博客地址 http://blog.libuqing.com/
//  Created by Love on 16/6/30.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "HXTagAttribute.h"

@implementation HXTagAttribute

- (instancetype)init
{
    self = [super init];
    if (self) {
       
        UIColor *normalColor = LYZTheme_paleBrown;
        UIColor *normalBackgroundColor = [UIColor whiteColor];
        UIColor *selectedBackgroundColor = [UIColor whiteColor];
        
        _borderWidth = 0.5f;
        _borderColor = LYZTheme_PinkishGeryColor;
        _cornerRadius = 27/2;
        _normalBackgroundColor = normalBackgroundColor;
        _selectedBackgroundColor = selectedBackgroundColor;
        _selectetextgroundColor  = LYZTheme_paleBrown;
        _selectedOrdergroundColor = LYZTheme_paleBrown;
        _normaltextgroundColor = LYZTheme_PinkishGeryColor;
        _normalBOrdergroundColor = LYZTheme_PinkishGeryColor;
        _titleSize = 14;
        _textColor = normalColor;
        _keyColor = [UIColor redColor];
        _tagSpace = 20;
    }
    return self;
}

@end
