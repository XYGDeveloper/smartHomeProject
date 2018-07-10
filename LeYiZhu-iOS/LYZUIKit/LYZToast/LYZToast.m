//
//  LYZToast.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZToast.h"
#import "LYZBaseToastView.h"

@interface LYZToast ()

@property (nonatomic, copy) NSString* titleString;
@property (nonatomic, copy) NSString* messageString;
@property (strong, nonatomic) UIImage* iconImage;

@property (strong, nonatomic) LYZBaseToastView*baseToastView;

@property handler handler;
@end

@implementation LYZToast

- (instancetype)initToastWithTitle:(NSString *)title message:(NSString *)message iconImage:(UIImage*)iconImage{
    
    self = [self init];
    if (self) {
        self.titleString = title;
        self.messageString = message;
        self.iconImage = iconImage;
    }
    return self;
}

/**
 重写init方法，加入默认属性
 */
- (id) init
{
    if (self = [super init]){
        [self initToastConfig];
    }
    return self;
}

/**
 初始化Toast基本配置（可以在这里修改一些默认效果）
 */
-(void)initToastConfig{
    
    
    //TextFont
    self.titleFont = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    self.messageFont = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    
    self.toastCornerRadius = 0.f;
    self.toastAlpha = 1.f;
    
    self.dismissToastAnimated = YES;
    
    //默认显示3s
    if (self.duration == 0) {
        self.duration = 3.f;
    }

    self.enableDismissBtn = YES;
    self.autoDismiss = YES;// <--------
}

- (void)show:(handler)handler{
    
    [self configBgAndTxetColor];
    //FFBaseToastView
    _baseToastView = [[LYZBaseToastView alloc] initToastWithTitle:_titleString message:_messageString iconImage:_iconImage];
    _baseToastView.toastBackgroundColor = _toastBackgroundColor;
    _baseToastView.titleTextColor = _titleTextColor;
    _baseToastView.messageTextColor = _messageTextColor;
    _baseToastView.titleFont = _titleFont;
    _baseToastView.messageFont = _messageFont;
    _baseToastView.toastCornerRadius = _toastCornerRadius;
    _baseToastView.toastAlpha = _toastAlpha;
    _baseToastView.duration = _duration;
    _baseToastView.dismissToastAnimated = _dismissToastAnimated;
    _baseToastView.supView = self.supView;
    _baseToastView.autoDismiss = NO;
    [_baseToastView show:^{
        _handler = handler;
        if (_handler) {
            _handler();
        }
    }];
}


-(void)configBgAndTxetColor{
    //默认背景色
    if (_toastBackgroundColor == nil) {
        self.toastBackgroundColor =LYZTheme_paleBrown;
    }
    //默认文字颜色
    if (_titleTextColor == nil) {
        //TextColor
        self.titleTextColor = [UIColor whiteColor];
    }
    if (_messageTextColor == nil) {
        self.messageTextColor = [UIColor whiteColor];
    }
}

- (void)dismissToast{
    if (_baseToastView != nil) {
        [_baseToastView dismiss];
    }

}

@end
