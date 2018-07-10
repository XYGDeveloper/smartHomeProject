//
//  YQAlertView.m
//  YQAlertView
//
//  Created by 余钦 on 16/5/4.
//  Copyright © 2016年 cmbfae Co.,Ltd. All rights reserved.
//

#import "YQAlertView.h"

#define MAXValue(a,b) ((a)>(b)? a:b)

#define TITLE_FONT_SIZE 18
#define MESSAGE_FONT_SIZE 15
#define BUTTON_FONT_SIZE 16

#define MARGIN_TOP 20
#define TITLE_HEIGHT 30
#define SPACE_LARGE 20

#define MARGIN_LEFT_RIGHT 20
#define MESSAGE_LINE_SPACE 5

@interface YQAlertView ()
@property (weak, nonatomic) UIView *backgroundView;
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *messageLabel;
@property(nonatomic, weak) UIView *horLine;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) NSMutableArray *buttonTitleArray;
@end

CGFloat contentViewWidth;
CGFloat contentViewHeight;

@implementation YQAlertView
- (NSMutableArray *)buttonArray{
    
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return  _buttonArray;
}

- (NSMutableArray *)buttonTitleArray{
    if (_buttonTitleArray == nil) {
        _buttonTitleArray = [NSMutableArray array];
    }
    return  _buttonTitleArray;
}


//由于可变参数传值问题，这种调用方法暂时只支持两个button，除非跟下面的函数一样写。
- (instancetype)initWithTitle:(NSString *)title icon:(UIImage *)icon message:(NSString *)message delegate:(id<YQAlertViewDelegate>)delegate buttonTitles:(NSString *)buttonTitles, ...{
    va_list args;
    va_start(args, buttonTitles);
    YQAlertView *yqAlert = [[YQAlertView alloc] initWithTitle:title message:message delegate:delegate buttonTitles:buttonTitles, va_arg(args, NSString *), nil];
    yqAlert.icon = icon;
    return yqAlert;
}


- (instancetype)initWithTitle:(NSString *)title attributeMessage:(NSMutableAttributedString *)attrMessage delegate:(id<YQAlertViewDelegate>)delegate buttonTitles:(NSString *)buttonTitles, ...{
    NSMutableArray *buttonTitleArray = [NSMutableArray array];
    
    va_list args;
    va_start(args, buttonTitles);
    if (buttonTitles)
    {
        [buttonTitleArray addObject:buttonTitles];
        while (1)
        {
            NSString *  otherButtonTitle = va_arg(args, NSString *);
            if(otherButtonTitle == nil) {
                break;
            } else {
                [buttonTitleArray addObject:otherButtonTitle];
            }
        }
    }
    va_end(args);
    
    YQAlertView *yqAlert = [[YQAlertView alloc]init];
    yqAlert.title = title;
    yqAlert.attrMessage = attrMessage;
    [yqAlert.attrMessage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, attrMessage.length)];
    yqAlert.buttonTitleArray = buttonTitleArray;
    yqAlert.delegate = delegate;
    [yqAlert showBackground];
    return yqAlert;

}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id<YQAlertViewDelegate>)delegate buttonTitles:(NSString *)buttonTitles, ... {
    NSMutableArray *buttonTitleArray = [NSMutableArray array];
    
    va_list args;
    va_start(args, buttonTitles);
    if (buttonTitles)
    {
        [buttonTitleArray addObject:buttonTitles];
        while (1)
        {
            NSString *  otherButtonTitle = va_arg(args, NSString *);
            if(otherButtonTitle == nil) {
                break;
            } else {
                [buttonTitleArray addObject:otherButtonTitle];
            }
        }
    }
    va_end(args);
    
    YQAlertView *yqAlert = [[YQAlertView alloc]init];
    yqAlert.title = title;
    yqAlert.message = message;
    yqAlert.buttonTitleArray = buttonTitleArray;
    yqAlert.delegate = delegate;
    [yqAlert showBackground];
    return yqAlert;
}

- (instancetype)init {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self SetupSubviews];
    }
    return self;
}

- (void)SetupSubviews
{
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor blackColor];
    [self addSubview:bgView];
    self.backgroundView = bgView;
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 5.0f;
    contentView.layer.masksToBounds = YES;
    [self addSubview:contentView];
    self.contentView = contentView;

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = HEX_RGBA(0x33, 0x33, 0x33, 1.0);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15.0f];
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;
    messageLabel.font  = [UIFont systemFontOfSize:15.0f];
    [self.contentView addSubview:messageLabel];
    self.messageLabel = messageLabel;
    
    UIView *horLine = [[UIView alloc] init];
    horLine.backgroundColor = HEX_RGBA(0xcc, 0xcc, 0xcc, 1.0);
    [self.contentView addSubview:horLine];
    self.horLine = horLine;
    
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.backgroundView.frame = self.frame;
    
    contentViewWidth = 240 * self.frame.size.width / 320;
    contentViewHeight = MARGIN_TOP*5;
    
    //title
    if (self.title.length) {
        self.titleLabel.frame = CGRectMake(0, 1, contentViewWidth, TITLE_HEIGHT);
    }
    
    //message
    CGFloat messageLabelX = MARGIN_LEFT_RIGHT;
    CGFloat messageLabelY = CGRectGetMaxY(self.titleLabel.frame) + SPACE_LARGE;
    CGFloat messageLabelMaxW = contentViewWidth - 2*MARGIN_LEFT_RIGHT;
    NSMutableDictionary *messageAttrs = [NSMutableDictionary dictionary];
    messageAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:MESSAGE_FONT_SIZE];
    CGSize messageLabelSize;
    if (self.message.length) {
        messageLabelSize = [self.message boundingRectWithSize:CGSizeMake(messageLabelMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:messageAttrs context:nil].size;
    }else if(self.attrMessage.length){
        messageLabelSize = [self.attrMessage boundingRectWithSize:CGSizeMake(messageLabelMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    }
    
    if (((contentViewWidth - messageLabelSize.width)/2) > MARGIN_LEFT_RIGHT) {
        self.messageLabel.frame = (CGRect){((contentViewWidth - messageLabelSize.width)/2), messageLabelY, messageLabelSize};
    }else{
        self.messageLabel.frame = (CGRect){messageLabelX, messageLabelY, messageLabelSize};
    }
    
    if (self.buttonTitleArray.count > 0) {
        //line
        CGFloat lineSize = 0.5f;
        self.horLine.frame = CGRectMake(0, CGRectGetMaxY(self.messageLabel.frame) + SPACE_LARGE, contentViewWidth, lineSize);
        
        CGFloat buttonW = contentViewWidth / _buttonTitleArray.count;
        CGFloat buttonH = 44.0f;
        
        self.contentView.frame = CGRectMake(0, 0, contentViewWidth, CGRectGetMaxY(self.horLine.frame) + buttonH);
        self.contentView.center = self.center;
        
        for (NSString *buttonTitle in _buttonTitleArray) {
            NSInteger index = [self.buttonTitleArray indexOfObject:buttonTitle];
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(index * (buttonW+lineSize), CGRectGetMaxY(self.horLine.frame), buttonW, 44)];
            button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
            [button setTitle:buttonTitle forState:UIControlStateNormal];
            if ([buttonTitle isEqualToString:@"确定"] || [buttonTitle isEqualToString:@"知道了"] || [buttonTitle isEqualToString:@"去加入"]) {
                [button setTitleColor:LYZTheme_paleBrown forState:UIControlStateNormal];

            }else{
            
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

            }
            [button addTarget:self action:@selector(buttonWithPressed:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonArray addObject:button];
            [_contentView addSubview:button];
            
            if (index < _buttonTitleArray.count - 1) {
                UIView *verLine = [[UIView alloc] init];
                verLine.backgroundColor = HEX_RGBA(0xcc, 0xcc, 0xcc, 1.0);
                verLine.frame = CGRectMake(CGRectGetMaxX(button.frame), button.frame.origin.y, lineSize, button.frame.size.height);
                [self.contentView addSubview:verLine];
            }
        }

    }else{
        self.contentView.frame = CGRectMake(0, 0, contentViewWidth, CGRectGetMaxY(self.messageLabel.frame) + SPACE_LARGE);
        self.contentView.center = self.center;
    }
    
}

- (void)buttonWithPressed:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(alertView: clickedButtonAtIndex:)]) {
        NSInteger index = [_buttonTitleArray indexOfObject:button.titleLabel.text];
        [self.delegate alertView:self clickedButtonAtIndex:index];
    }
    [self hide];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setMessage:(NSString *)message {
    _message = message;
    self.messageLabel.text = message;
}

- (void)setAttrMessage:(NSMutableAttributedString *)attrMessage{
    _attrMessage = attrMessage;
    self.messageLabel.attributedText = attrMessage;
}

- (void)Show{
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    NSArray *windowViews = [window subviews];
    if(windowViews && [windowViews count] > 0){
        UIView *subView = [windowViews objectAtIndex:[windowViews count]-1];
        for(UIView *aSubView in subView.subviews)
        {
            [aSubView.layer removeAllAnimations];
        }
        [subView addSubview:self];
        [self showBackground];
        [self showAlertAnimation];
    }

}

- (void)showBackground
{
    self.backgroundView.alpha = 0;
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration:0.35];
    self.backgroundView.alpha = 0.6;
    [UIView commitAnimations];
}

-(void)showAlertAnimation
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.30;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.contentView.layer addAnimation:animation forKey:nil];
}

- (void)hide {
    self.contentView.hidden = YES;
    [self hideAlertAnimation];
    [self removeFromSuperview];
}

- (void)hideAlertAnimation {
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration:0.35];
    self.backgroundView.alpha = 0.0;
    [UIView commitAnimations];
}
@end
