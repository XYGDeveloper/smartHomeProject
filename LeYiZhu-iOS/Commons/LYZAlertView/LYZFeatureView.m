//
//  LYZFeatureView.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/2.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZFeatureView.h"
#import "UIView+SetRect.h"
#import "UIView+UserInteraction.h"
#import "POP.h"
#import "InfiniteLoopViewBuilder.h"
#import "CircleNodeStateView.h"
#import "ImageModel.h"
#import "LoopViewCell.h"


@interface LYZFeatureView  ()<InfiniteLoopViewBuilderEventDelegate>

@property (nonatomic, strong)  UIView  *blackView;
@property (nonatomic, strong)  UIView  *messageView;
@property (nonatomic, strong) UIButton *closeBtn;


@end

@implementation LYZFeatureView

- (void)show {
    
    if (self.contentView) {
        
        [self.contentView addSubview:self];
        
        self.contentViewUserInteractionEnabled == NO ? [self.contentView enabledUserInteraction] : 0;
        [self createBlackView];
        [self createUpdateView];
        
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
        
        self.blackView.alpha = 0.5f;
        
    } completion:^(BOOL finished) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(baseMessageViewDidAppear:)]) {
            
            [self.delegate baseMessageViewDidAppear:self];
        }
    }];
}

- (void)createUpdateView {
    FeatureViewMessageObject *message = self.messageObject;
    
    // 创建信息窗体view
    self.messageView                   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 450)];
//    self.messageView.backgroundColor   = [[UIColor whiteColor] colorWithAlphaComponent:0.985f];
    self.messageView.backgroundColor   = [UIColor clearColor];
    self.messageView.center            = self.contentView.middlePoint;
    self.messageView.alpha             = 0.f;
//    self.messageView.layer.cornerRadius = 8.0f;
//    self.messageView.clipsToBounds = YES;
    self.messageView.center  = self.contentView.middlePoint;
    [self addSubview:self.messageView];
    
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.messageView.width, 22)];
    headImgView.image = [UIImage imageNamed:@"Feature_title"];
    [self.messageView addSubview:headImgView];
    
    NSArray *strings =    message.imgs;
    NSMutableArray *models = [NSMutableArray array];
    for (int i = 0; i < strings.count; i++) {
        
        ImageModel *model                     = [[ImageModel alloc] init];
        model.img = [UIImage imageNamed:strings[i]];
        
        // Setup model.
        model.infiniteLoopCellClass           = [LoopViewCell class];
        model.infiniteLoopCellReuseIdentifier = [NSString stringWithFormat:@"LoopViewCell_%d", i];
        [models addObject:model];
    }
    InfiniteLoopViewBuilder *loopView = [[InfiniteLoopViewBuilder alloc] initWithFrame:CGRectMake(0, 50, self.messageView.width,400)];
    loopView.nodeViewTemplate         = [CircleNodeStateView new];
    loopView.delegate                 = self;
    loopView.sampleNodeViewSize       = CGSizeMake(15, 10);
    loopView.position                 = kNodeViewBottom;
    loopView.edgeInsets               = UIEdgeInsetsMake(0, 0, -20, 5);
    loopView.models                   = (NSArray <InfiniteLoopViewProtocol, InfiniteLoopCellClassProtocol> *)models;
    loopView.initialIndex            = message.index;
    [loopView startLoopAnimated:NO];
    [self.messageView addSubview:loopView];
//    UIView *blackView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, loopView.width, 20)];
//    blackView.bottom          = loopView.height;
//    blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
//    [loopView.contentView addSubview:blackView];


    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake(0, 0, 30, 30);
    [self.closeBtn setImage:[UIImage imageNamed:@"icon_Alert_close"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    self.closeBtn.center = self.contentView.middlePoint;
    self.closeBtn.y =  self.messageView.bottom + 40;
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


@end

@implementation FeatureViewMessageObject


@end
