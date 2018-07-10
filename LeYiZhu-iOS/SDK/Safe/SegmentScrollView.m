//
//  SegmentScrollView.m
//  Qqw
//
//  Created by zagger on 16/8/20.
//  Copyright © 2016年 gao.jian. All rights reserved.
//

#import "SegmentScrollView.h"

@implementation SegmentScrollView

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint velocity = [pan velocityInView:self];
        if (velocity.x > 0) {
            CGPoint location = [pan locationInView:self];
            return location.x > [UIScreen mainScreen].bounds.size.width;
        }
    }
    
    return YES;
}

@end
