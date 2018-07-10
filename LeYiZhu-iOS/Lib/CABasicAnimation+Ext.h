//
//  CABasicAnimation+Ext.h
//  CABasicAnimation_Ext_Demo
//
//  Created by admin on 16/6/28.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>


@interface CABasicAnimation (Ext)


/**
 *  forever twinkling  永久闪烁的动画
 *
 *  @param time   time duration 持续时间
 *
 *  @return self   返回当前类
 */
+ (CABasicAnimation *)opacityForever_Animation:(float)time;



@end
