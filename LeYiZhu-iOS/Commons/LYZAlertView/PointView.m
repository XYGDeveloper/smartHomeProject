//
//  PointView.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/16.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "PointView.h"
#import "UIView+SetRect.h"
#import "UIView+UserInteraction.h"
#import "POP.h"

#define kMessageWidth 170
#define kImgWidth 50

@interface PointView  ()

@property (nonatomic, strong)  UIView  *blackView;
@property (nonatomic, strong)  UIView  *messageView;

@end


@implementation PointView

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
    
    PointViewMessageObject *message = self.messageObject;
    
    {
        // 创建信息窗体view
        self.messageView                   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMessageWidth, kMessageWidth)];
        self.messageView.backgroundColor   = [[UIColor whiteColor] colorWithAlphaComponent:0.985f];
        self.messageView.center            = self.contentView.middlePoint;
        self.messageView.alpha             = 0.f;
        self.messageView.layer.cornerRadius = 6.0f;
        [self addSubview:self.messageView];
        
        UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kImgWidth, kImgWidth)];
        headImgView.centerX = self.messageView.width / 2.0;
        headImgView.y = 30;
        if (message.imgName) {
            headImgView.image = [UIImage imageNamed:message.imgName];
        }
        
        [self.messageView addSubview:headImgView];
        
        UILabel *titleLabel = [[UILabel alloc]  initWithFrame:CGRectZero];
        titleLabel.textColor = RGB(215, 175, 120);
        titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:17];
        titleLabel.text = message.title;
        [titleLabel sizeToFit];
        titleLabel.centerX = self.messageView.width /2.0;
        titleLabel.y = headImgView.bottom + 15;
        [self.messageView addSubview:titleLabel];
        
        UILabel *subtitleLabel = [[UILabel alloc]  initWithFrame:CGRectZero];
        subtitleLabel.textColor = RGB(153, 153, 153);
        subtitleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
        subtitleLabel.text = message.subtitle;
        [subtitleLabel sizeToFit];
        subtitleLabel.centerX = self.messageView.width /2.0;
        subtitleLabel.y = titleLabel.bottom + 15;
        [self.messageView addSubview:subtitleLabel];
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

#pragma mark - PointViewMessageObject

@implementation PointViewMessageObject

@end
