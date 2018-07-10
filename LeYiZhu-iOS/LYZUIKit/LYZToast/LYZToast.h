//
//  LYZToast.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYZToastConfig.h"

@interface LYZToast : NSObject

//Toast点击回调
typedef void(^handler)(void);

//背景颜色
@property (strong, nonatomic) UIColor* toastBackgroundColor;
//Toast标题文字颜色
@property (strong, nonatomic) UIColor* titleTextColor;
//Toast内容文字颜色
@property (strong, nonatomic) UIColor* messageTextColor;

//Toast标题文字字体
@property (strong, nonatomic) UIFont* titleFont;
//Toast文字字体
@property (strong, nonatomic) UIFont* messageFont;

//Toast View圆角
@property(assign,nonatomic)CGFloat toastCornerRadius;
//Toast View透明度
@property(assign,nonatomic)CGFloat toastAlpha;

//Toast显示时长
@property(assign,nonatomic)NSTimeInterval duration;
//Toast消失动画是否启用
@property(assign,nonatomic)BOOL dismissToastAnimated;

////Toast显示位置
//@property (assign, nonatomic) FFToastPosition toastPosition;
////Toast显示类型
//@property (assign, nonatomic) FFToastType toastType;

//是否自动隐藏
@property(assign,nonatomic)BOOL autoDismiss;
//是否在右上角显示隐藏按钮
@property(assign,nonatomic)BOOL enableDismissBtn;
//隐藏按钮的图标
@property (strong, nonatomic) UIImage* dismissBtnImage;

@property (weak, nonatomic) UIView *supView;

/**
 创建一个Toast
 
 @param title 标题
 @param message 消息内容
 @param iconImage 消息icon
 @return Toast
 */
- (instancetype)initToastWithTitle:(NSString *)title message:(NSString *)message iconImage:(UIImage*)iconImage;



/**
 显示一个Toast
 
 @param handler Toast点击回调
 */
- (void)show:(handler)handler;

/**
 隐藏一个Toast
 */
- (void)dismissToast;

@end
