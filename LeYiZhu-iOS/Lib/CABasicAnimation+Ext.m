//
//  CABasicAnimation+Ext.m
//  CABasicAnimation_Ext_Demo
//
//  Created by admin on 16/6/28.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "CABasicAnimation+Ext.h"

@implementation CABasicAnimation (Ext)


+ (CABasicAnimation *)opacityForever_Animation:(float)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @1.f;
    animation.toValue = @0;
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    //定义动画的样式 渐入式
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return animation;
}



@end
