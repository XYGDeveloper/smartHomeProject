//
//  LYZTextField.m
//  LeYiZhu-iOS
//
//  Created by mac on 2016/12/1.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "LYZTextField.h"

@implementation LYZTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGFloat width = 30;
    CGRect rect = CGRectMake(bounds.size.width * 0.5 - width * 0.5 , (bounds.size.height - width) * 0.5, width, width);
    return rect;
    
}

@end
