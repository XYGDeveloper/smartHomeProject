//
//  AnnouncementView.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/4.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AnnouncementView.h"
#import "UIView+UserInteraction.h"
#import "POP.h"
#import "UIView+SetRect.h"

@interface AnnouncementView  ()

@property (nonatomic, strong)  UIView  *blackView;
@property (nonatomic, strong)  UIView  *messageView;
@property (nonatomic, strong)  UIButton *closeBtn;

@end

@implementation AnnouncementView

- (void)show {
    
    if (self.contentView) {
        
        [self.contentView addSubview:self];
        
        self.contentViewUserInteractionEnabled == NO ? [self.contentView enabledUserInteraction] : 0;
        [self createBlackView];
        [self createAnnoucementView];
        
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

- (void)createAnnoucementView {
    
    AnnoucementViewObject *message = self.messageObject;
    
    // 创建信息窗体view
    self.messageView                   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 26.5 *2, 0)];
    self.messageView.backgroundColor   = [[UIColor whiteColor] colorWithAlphaComponent:0.985f];
    self.messageView.alpha             = 0.f;
    self.messageView.layer.cornerRadius = 6.0f;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textColor = RGB(51, 51, 51);
    titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    titleLabel.text = @"使用说明";
    [titleLabel sizeToFit];
    
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineSpacing = 6;// 字体的行间距
//
//    NSDictionary *attributes = @{
//                                 NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:14],
//                                 NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:LYZTheme_BrownishGreyFontColor
//                                 };
    UITextView *textView = [[UITextView alloc]  initWithFrame:CGRectMake(0,0, self.messageView.width - 25 * 2 , 0)];
    textView.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    textView.textColor = RGB(102, 102, 102);
    textView.editable = NO;
//    textView.attributedText =  [[NSAttributedString alloc] initWithString:message.annoucement attributes:attributes];
    textView.text = message.annoucement;
    CGFloat height = [textView sizeThatFits:CGSizeMake(textView.width , FLT_MAX)].height ;
//    height += 22;
//    CGSize constraintSize = CGSizeMake(textView.width, MAXFLOAT);
//    CGSize size = [textView sizeThatFits:constraintSize];
   
    self.messageView.height = 25 + titleLabel.height + 15 + height + 20;
    self.messageView.center  = self.contentView.middlePoint;
     [self addSubview:self.messageView];
    
  
    titleLabel.y = 25;
    titleLabel.centerX = self.messageView.width/2.0;
    [self.messageView addSubview:titleLabel];
   
    
    textView.x = 25;
    textView.y = titleLabel.bottom + 15;
     textView.height = height;
    [self.messageView addSubview:textView];
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake(0, 0, 30, 30);
    [self.closeBtn setImage:[UIImage imageNamed:@"icon_Alert_close"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.closeBtn.center = self.contentView.middlePoint;
    self.closeBtn.y =  self.messageView.bottom + 50;
    [self addSubview:self.closeBtn];
    
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

-(void)closeBtnClick:(UIButton *)sender{
        [self hide];
}

@end

#pragma mark - GifIndicatorViewObject

@implementation AnnoucementViewObject

@end
