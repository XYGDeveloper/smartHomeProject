//
//  TFModalViewController.h
//  20141109-01TFModalViewController框架
//
//  Created by btz-mac on 14-11-9.
//  Copyright (c) 2014年 朱佰通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "TFModalViewControllerPublic.h"

@class TFModalViewController;


@interface TFModalViewController : UIViewController


/** 返回单例对象 */
+ (instancetype)sharedModalViewController;



/**
 *  弹出一个控制器在当前的控制器之上. [scale : 弹出的比例]-[direction : 弹出的方向]
 *
 *  @param controller 要显示的控制器
 *  @param scale      显示比例 , 取值范围 (0.0~1.0] ,超出范围的值会以默认值0.75的比例显示.
 *  @param direction  弹出方向 , 见枚举值TFModalViewControllerShowDirection
 *  @param superViewController  需要弹出界面的父级控制器
 *  @param completionBlock     界面显示完成后调用的block
 */
- (void)showModalViewWithController : (UIViewController *)controller AndShowScale : (CGFloat)scale AndShowDirection : (TFModalViewControllerShowDirection)direction FromSuperViewController : (UIViewController *)superViewController WithShowCompletionBlock : (TFModalViewControllerShowCompletionBlock)completionBlock;


/** 隐藏弹出的控制器 , 当界面完全隐藏之后执行block内的代码 */
- (void)hiddenModalViewController : (UIViewController *)controller WithHiddenCompletionBlock : (TFModalViewControllerHiddenCompletionBlock)completionBlock;


@end





