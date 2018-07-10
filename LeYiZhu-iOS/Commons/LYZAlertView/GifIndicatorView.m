//
//  GifIndicatorView.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/10/31.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GifIndicatorView.h"
#import "UIView+SetRect.h"
#import "UIView+UserInteraction.h"
#import "POP.h"
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"

@interface GifIndicatorView  ()

@property (nonatomic, strong)  UIView  *blackView;
@property (nonatomic, strong)  UIView  *messageView;

@end

@implementation GifIndicatorView

- (void)show {
    
    if (self.contentView) {
        
        [self.contentView addSubview:self];
        
        self.contentViewUserInteractionEnabled == NO ? [self.contentView enabledUserInteraction] : 0;
        [self createBlackView];
        [self createGifIndicatorView];
        
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

- (void)createGifIndicatorView {
    
    GifIndicatorViewObject *message = self.messageObject;
    FLAnimatedImageView *gifImageView = [[FLAnimatedImageView alloc] init];
    FLAnimatedImage *gifImage = [FLAnimatedImage animatedImageWithGIFData:message.gifData];
    gifImageView.frame           = CGRectMake(0, 0, gifImage.size.width, gifImage.size.height);
//    gifImageView.center          = self.contentView.middlePoint;
    gifImageView.animatedImage   = gifImage;
    gifImageView.alpha           = 1.f;
    
//    [UIView animateWithDuration:0.5f animations:^{
//
//        gifImageView.alpha = 1.f;
//    }];
//    [self.contentView addSubview:gifImageView];

    // 创建信息窗体view
    self.messageView                   = [[UIView alloc] initWithFrame:CGRectMake(0, 0,gifImageView.width, gifImageView.height)];
//    self.messageView.backgroundColor   = [[UIColor whiteColor] colorWithAlphaComponent:0.985f];
    self.messageView.backgroundColor   = [UIColor clearColor];
    self.messageView.center            = self.contentView.middlePoint;
    self.messageView.alpha             = 1.f;
    self.messageView.layer.cornerRadius = 6.0f;
    [self.messageView addSubview:gifImageView];
    gifImageView.center          = self.messageView.middlePoint;
    gifImageView.x += 20;
//    [UIView animateWithDuration:0.5f animations:^{
//
//        gifImageView.alpha = 1.f;
//    }];
    [self.messageView addSubview:gifImageView];
    [self addSubview:self.messageView];
    
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

- (void)buttonEvent:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseMessageView:event:)]) {
        
        [self.delegate baseMessageView:self event:[button titleForState:UIControlStateNormal]];
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

#pragma mark - GifIndicatorViewObject

@implementation GifIndicatorViewObject

@end

