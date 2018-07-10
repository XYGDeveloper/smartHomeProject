//
//  LYZAdView.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/3.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZAdView.h"
#import "UIView+SetRect.h"
#import "UIView+UserInteraction.h"
#import "POP.h"
#import "UIImageView+WebCache.h"

@interface LYZAdView  ()

@property (nonatomic, strong)  UIView  *blackView;
@property (nonatomic, strong)  UIView  *messageView;
@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation LYZAdView

- (void)show {
    
    if (self.contentView) {
    
        [self.contentView addSubview:self];
        
        self.contentViewUserInteractionEnabled == NO ? [self.contentView enabledUserInteraction] : 0;
        [self createBlackView];
        [self createAdView];
        
        if (self.autoHiden) {
            [self performSelector:@selector(hide) withObject:nil afterDelay:self.delayAutoHidenDuration];
        }
    }
}

- (void)hide {
    
    if (self.contentView) {
        
        [self removeViews];
    }
}

- (void)createBlackView {
    
    self.blackView                 = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.blackView.backgroundColor = [UIColor blackColor];
    self.blackView.alpha           = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 1;
    [tap addTarget:self action:@selector(hide)];
    [self.blackView addGestureRecognizer:tap];
    
    [self addSubview:self.blackView];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseMessageViewWillAppear:)]) {
        
        [self.delegate baseMessageViewWillAppear:self];
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.blackView.alpha = 0.25f;
        
    } completion:^(BOOL finished) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(baseMessageViewDidAppear:)]) {
            
            [self.delegate baseMessageViewDidAppear:self];
        }
    }];
}

- (void)createAdView {
    
    AdViewMessageObject *message = self.messageObject;
    
    {

        // 创建信息窗体view
        self.messageView                   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 322, 430)];
        self.messageView.backgroundColor   = [[UIColor whiteColor] colorWithAlphaComponent:0.985f];
        self.messageView.center            = self.contentView.middlePoint;
        self.messageView.alpha             = 0.f;
        self.messageView.layer.cornerRadius = 6.0f;
        [self addSubview:self.messageView];
        
        UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.messageView.width, self.messageView.height)];
        if (message.imgUrl) {
               [headImgView sd_setImageWithURL:[NSURL URLWithString:message.imgUrl] placeholderImage:nil];
        }
        if (message.imgName) {
            headImgView.image = [UIImage imageNamed:message.imgName];
        }
        if (message.canClick) {
            headImgView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
            tap.numberOfTapsRequired = 1;
            [headImgView addGestureRecognizer:tap];
        }
        [self.messageView addSubview:headImgView];
       
        self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.closeBtn.frame = CGRectMake(0, 0, 30, 30);
        [self.closeBtn setImage:[UIImage imageNamed:@"icon_Alert_close"] forState:UIControlStateNormal];
        [self.closeBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        self.closeBtn.center = self.contentView.middlePoint;
        self.closeBtn.y =  self.messageView.bottom + 50;
        [self addSubview:self.closeBtn];
    }
    
    // 执行动画
    POPBasicAnimation  *alpha = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    alpha.toValue             = @(1.f);
    alpha.duration            = 0.3f;
    [self.messageView pop_addAnimation:alpha forKey:nil];
    
    POPSpringAnimation *scale = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scale.fromValue           = [NSValue valueWithCGSize:CGSizeMake(1.75f, 1.75f)];
    scale.toValue             = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scale.dynamicsTension     = 1000;
    scale.dynamicsMass        = 1.3;
    scale.dynamicsFriction    = 10.3;
    scale.springSpeed         = 20;
    scale.springBounciness    = 15.64;
    [self.messageView.layer pop_addAnimation:scale forKey:nil];
    
    scale.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        
        [self.messageView.subviews enumerateObjectsUsingBlock:^(__kindof UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIButton class]]) {
                UIButton *button              = obj;
                button.userInteractionEnabled = YES;
            }
        }];
    };
}




- (void)clickAction{
    AdViewMessageObject *message = self.messageObject;
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseMessageView:event:)]) {
        [self.delegate baseMessageView:self event:message];
    }
}

- (void)removeViews {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseMessageViewWillDisappear:)]) {
        
        [self.delegate baseMessageViewWillDisappear:self];
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        
        self.blackView.alpha       = 0.f;
        self.messageView.alpha     = 0.f;
        self.messageView.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
        
    } completion:^(BOOL finished) {
        
        self.contentViewUserInteractionEnabled == NO ? [self.contentView disableUserInteraction] : 0;
        [self removeFromSuperview];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(baseMessageViewDidDisappear:)]) {
            
            [self.delegate baseMessageViewDidDisappear:self];
        }
    }];
}

@end

#pragma mark - AdViewMessageObject

@implementation AdViewMessageObject

@end


