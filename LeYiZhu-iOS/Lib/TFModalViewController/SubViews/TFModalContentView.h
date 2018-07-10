//
//  TFModalContentView.h
//  20141109-01TFModalViewController框架
//
//  Created by btz-mac on 14-11-9.
//  Copyright (c) 2014年 朱佰通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TFModalViewControllerPublic.h"

/** 默认的显示比例 */
#define ModalView_ShowScale_Default 0.75


/** 动画完成后的回调block */
typedef void(^TFModalContentViewAnimationCompletionBlock)(void);


@interface TFModalContentView : UIScrollView


/** 在其上展示的控制器 */
@property (nonatomic , weak) UIViewController * visbleController;

/** 初始化方法 */
- (instancetype)initWithVisibleView : (UIView *)visibleView AndScale : (CGFloat)scale AndDirection: (TFModalViewControllerShowDirection)direction;


/** 进场显示动画 */
- (void)showAnimationInWithCompletionBlock : (TFModalContentViewAnimationCompletionBlock)completionBlock;

/** 出场隐藏动画 */
- (void)showAnimationOutWithCompletionBlock : (TFModalContentViewAnimationCompletionBlock)completionBlock;


@end


