//
//  XFAlertView.m
//  SCPay
//
//  Created by weihongfang on 2017/6/28.
//  Copyright © 2017年 weihongfang. All rights reserved.
//

#import "XFAlertView.h"
#import "UILabel+XFLabel.h"
#import "Masonry.h"

@interface XFAlertView()

@property (nonatomic, retain)NSString       *title;
@property (nonatomic, retain)NSString       *msg;
@property (nonatomic, retain)NSString       *cancelBtnTitle;
@property (nonatomic, retain)NSString       *okBtnTitle;
@property (nonatomic, retain)UIImage        *img;

@property (nonatomic, strong)UILabel        *lblTitle;
@property (nonatomic, strong)UILabel        *lblMsg;
@property (nonatomic, strong)UIButton       *btnCancel;
@property (nonatomic, strong)UIButton       *btnOK;
@property (nonatomic, strong)UIImageView    *imgView;

@property (strong, nonatomic) UIView        *backgroundView;

@end

@implementation XFAlertView

- (instancetype)initWithTitle:(NSString *)title Msg:(NSString *)msg CancelBtnTitle:(NSString *)cancelBtnTtile OKBtnTitle:(NSString *)okBtnTitle Img:(UIImage *)img
{
    if ([super init])
    {
        _title = title;
        _msg = msg;
        _cancelBtnTitle = cancelBtnTtile;
        _okBtnTitle = okBtnTitle;
        _img = img;
        
        self.backgroundColor = [UIColor whiteColor];
        
        _lblTitle = [[UILabel alloc]init];
        _lblTitle.textColor = [UIColor blackColor];
        _lblTitle.textAlignment = NSTextAlignmentCenter;
        _lblTitle.font = [UIFont systemFontOfSize:15];
        _lblTitle.text = _title;
        _lblTitle.numberOfLines = 0;
        [self addSubview:_lblTitle];
        
        _lblMsg = [[UILabel alloc]init];
        _lblMsg.textColor = [UIColor blackColor];
        _lblMsg.textAlignment = NSTextAlignmentCenter;
        _lblMsg.font = [UIFont systemFontOfSize:15];
        _lblMsg.text = _msg;
        _lblMsg.numberOfLines = 0;
        [self addSubview:_lblMsg];
        
        _btnCancel = [[UIButton alloc]init];
        [_btnCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btnCancel.titleLabel.font  = [UIFont systemFontOfSize:15.0f];
        [_btnCancel setTitle:_cancelBtnTitle forState:UIControlStateNormal];
        [_btnCancel addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnCancel];
        
        _btnOK = [[UIButton alloc]init];
        [_btnOK setTitleColor:LYZTheme_paleBrown forState:UIControlStateNormal];
        _btnOK.titleLabel.font  = [UIFont systemFontOfSize:15.0f];
        [_btnOK setTitle:_okBtnTitle forState:UIControlStateNormal];
        [_btnOK addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnOK];
        
        _imgView = [[UIImageView alloc]init];
        _imgView.image = _img;
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imgView];
        
        [self.backgroundView addSubview:self];
    }
    return self;
}

- (UIView *)backgroundView
{
    if (_backgroundView == nil)
    {
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        
        _backgroundView.layer.masksToBounds = YES;
    }
    
    return _backgroundView;
}

- (void)layoutSubviews
{
    CGFloat alertViewWidth = kScreenWidth- 80;
    
    CGRect imgRect = CGRectZero;
    CGRect titleRect = CGRectZero;
    CGRect msgRect = CGRectZero;
    CGRect cancelRect = CGRectZero;
    CGRect okRect = CGRectZero;
    
    if (_img != nil)
    {
        imgRect = CGRectMake(0, 20, alertViewWidth, 60);
    }
    
    titleRect = CGRectMake(0,
                           CGRectGetMaxY(imgRect) + 15,
                           alertViewWidth,
                           [UILabel getHeightByWidth:alertViewWidth title:_title font:_lblTitle.font]);
    
    msgRect = CGRectMake(0,
                         CGRectGetMaxY(titleRect) + 15,
                         alertViewWidth,
                         [UILabel getHeightByWidth:alertViewWidth title:_msg font:_lblMsg.font]);
    
    if (_okBtnTitle == nil)
    {
        cancelRect = CGRectMake(40, CGRectGetMaxY(msgRect) + 15, alertViewWidth - (40 * 2), 36);
    }
    else
    {
        cancelRect = CGRectMake((alertViewWidth / 2 - alertViewWidth * 0.5) / 2,
                                CGRectGetMaxY(msgRect) + 15,
                                alertViewWidth * 0.5,
                                45);
        
        okRect = CGRectMake((alertViewWidth / 2) +  cancelRect.origin.x,
                            CGRectGetMaxY(msgRect) + 15,
                            alertViewWidth * 0.5,
                            45);
    }
    
    _imgView.frame = imgRect;
    _lblTitle.frame = titleRect;
    _lblMsg.frame = msgRect;
    _btnCancel.frame = cancelRect;
    _btnOK.frame = okRect;
    _btnOK.layer.borderWidth = 0.5;
    _btnCancel.layer.borderWidth = 0.5;
    _btnOK.layer.borderColor = LYZTheme_paleGreyFontColor.CGColor;
    _btnCancel.layer.borderColor = LYZTheme_paleGreyFontColor.CGColor;
    CGFloat alertHeight = CGRectGetMaxY(_btnCancel.frame) + 0;
    
    self.frame = CGRectMake((_backgroundView.frame.size.width - alertViewWidth) / 2,
                            (_backgroundView.frame.size.height - alertHeight) / 2,
                            alertViewWidth,
                            alertHeight);
    
    self.layer.cornerRadius = 5;
    
}

- (void)clickBtn:(UIButton *)sender
{
    NSLog(@"XFAlertView: click %@", [sender titleForState:UIControlStateNormal]);
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(alertView:didClickTitle:)])
    {
        [self.delegate alertView:self didClickTitle:[sender titleForState:UIControlStateNormal]];
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        
    } completion:^(BOOL finished) {
        
        [self.backgroundView removeFromSuperview];
    }];
}

#pragma mark - public method

- (void)show
{
    [[UIApplication sharedApplication].delegate.window addSubview:self.backgroundView];
    
    [UIView animateWithDuration:0.1 animations:^{
        
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
    } completion:nil];
}


@end
