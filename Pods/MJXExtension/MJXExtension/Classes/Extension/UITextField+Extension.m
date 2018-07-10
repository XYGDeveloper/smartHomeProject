//
//  UITextField+Extension.m
//  基础框架
//
//  Created by MJX on 2017/7/3.
//  Copyright © 2017年 ShangTong. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

- (void)setLeftVacancyLength:(CGFloat)length{
    
    if (length < 10) {
        length = 10;
    }
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,length, 0)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

@end
