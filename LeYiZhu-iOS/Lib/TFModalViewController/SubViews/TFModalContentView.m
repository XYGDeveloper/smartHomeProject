//
//  TFModalContentView.m
//  20141109-01TFModalViewController框架
//
//  Created by btz-mac on 14-11-9.
//  Copyright (c) 2014年 朱佰通. All rights reserved.
//



#import "TFModalContentView.h"
#import "UIViewController+TFModalView.h"





@interface TFModalContentView ()

/** 遮板 */
@property (nonatomic , weak) UIView * backgroundView;

/** 要显示的view */
@property (nonatomic , weak) UIView * visibleView;

/** 要显示的view的显示比例 */
@property (nonatomic , assign) CGFloat  scale;

/** 要显示的view的入场方向 */
@property (nonatomic , assign) TFModalViewControllerShowDirection  direction;


/** 动画进行标志位 */
@property (nonatomic , assign) BOOL  animationOutFlag;


/** 记录visbleView最初显示的真实center */
@property (nonatomic , assign) CGPoint defalutCenter;

@end

@implementation TFModalContentView

#pragma mark - 初始化

/** 初始化方法 */
- (instancetype)initWithVisibleView : (UIView *)visibleView AndScale : (CGFloat)scale AndDirection: (TFModalViewControllerShowDirection)direction
{
    self = [super init];
    if (self)
    {
        if (scale <= 0 || scale >1)
            scale = ModalView_ShowScale_Default;
        
        if (!visibleView)
        {
            NSLog(@"[%s--第%d行]--[错误:传入的显示界面参数有误!]",__func__,__LINE__);
            return self;
        }
        
        /** 初始化蒙板 */
        [self backgroundView];
        
        [self addSubview:visibleView];
        self.visibleView = visibleView;
        self.visibleView.hidden = YES;
        
        self.scale = scale;
        self.direction = direction;
        
        /** 初始化容器属性 */
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.scrollEnabled = NO;
        
        /** 添加手势 */
        [self addMyRecognizerToBackgroundView];
        [self addMyRecognizerToSelf];
        
        /** 设置KVO监听 */
        [self.visibleView addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
    }

    return self;
}


#pragma mark - 参数懒加载

/** 遮板 */
- (UIView *)backgroundView
{
    if(_backgroundView == nil)
    {
        UIView * temp = [[UIView alloc] init];
        
        temp.backgroundColor = TF_ModalView_Background_Color;
        temp.alpha = TF_ModalView_Background_Alpha;
        
        [self addSubview:temp];
        _backgroundView = temp ;
    }
    
    return _backgroundView;
}


#pragma mark - KVO监听方法

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

//    NSLog(@"监听到数据:%@",change);

    /** 根据visbleView的center的变化来改变背景透明度 */
    if (object == self.visibleView && [keyPath isEqualToString:@"center"])
    {
        NSValue * point = change[@"new"];
        //NSLog(@"监听到数据:%@",point);
        
        CGFloat scale = 0.0;

        switch (self.direction) {
            case TFModalViewControllerShowDirectionFromLeft:
            case TFModalViewControllerShowDirectionFromRight:
            {
                CGFloat newX = point.CGPointValue.x;
                CGFloat offsetX = newX - self.defalutCenter.x ;
                
                 scale = fabs(offsetX) / self.visibleView.bounds.size.width;

            }
                break;
                
            case TFModalViewControllerShowDirectionFromTop:
            case TFModalViewControllerShowDirectionFromBottom:
            {
                CGFloat newY = point.CGPointValue.y;
                CGFloat offsetY = newY - self.defalutCenter.y ;
                
                scale = fabs(offsetY) / self.visibleView.bounds.size.height;
                
            }
                break;
                
            default:
                return;
                break;
        }
        

        if (scale > 1.0)
            scale = 1.0;

        self.backgroundView.alpha = ( 1- scale ) * TF_ModalView_Background_Alpha;

    }
    
    
}

#pragma mark - Frame 计算方法


- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    /** 布局自身的frame属性 */
    [self layoutSelf];
    
    /** 布局底层遮板 */
    [self layoutMyBackgroundView];

    /** 如果正在动画 ,则这里不改变visibleView的frame */
    if (!self.animationOutFlag)
    {
        /** 布局visibleView */
        [self layoutMyVisibleView];
    
    }

}

/** 布局自身的frame属性 */
- (void)layoutSelf
{
    self.frame = self.superview.bounds;
    self.contentSize = self.bounds.size;
}

/** 布局底层遮板 */
- (void)layoutMyBackgroundView
{
    self.backgroundView.frame = self.bounds;
}

/** 布局visibleView */
- (void)layoutMyVisibleView
{
   
    /** 计算visibleView的size */
    CGSize size = CGSizeZero;
    
    /** 根据入场方向设置size */
    switch (self.direction) {
        case TFModalViewControllerShowDirectionFromLeft:
        case TFModalViewControllerShowDirectionFromRight:
        {
            CGFloat height = self.bounds.size.height;
            CGFloat width = self.bounds.size.width * self.scale;
            
            size = CGSizeMake(width, height);

        }
            break;
            
        case TFModalViewControllerShowDirectionFromTop:
        case TFModalViewControllerShowDirectionFromBottom:
        {
            CGFloat height = self.bounds.size.height * self.scale;
            CGFloat width = self.bounds.size.width ;
            
            size = CGSizeMake(width, height);
        
        }
            break;
            
        default:
            
            NSLog(@"[%s--第%d行]--[错误:进场方向参数传入错误!]",__func__,__LINE__);

            break;
    }
    

    /** 计算visibleView的位置 */
    CGPoint point = CGPointZero;
    
    /** 根据入场方向设置size */
    switch (self.direction) {
        case TFModalViewControllerShowDirectionFromLeft:
        case TFModalViewControllerShowDirectionFromTop:
        {
            CGFloat x = 0;
            CGFloat y = 0;
            
            point = CGPointMake(x, y);
            
        }
            break;
            
        case TFModalViewControllerShowDirectionFromRight:
        {
            CGFloat x = self.bounds.size.width - size.width;
            CGFloat y = 0;
            
            point = CGPointMake(x, y);
       
        }
            break;
        case TFModalViewControllerShowDirectionFromBottom:
        {
            CGFloat x = 0;
            CGFloat y = self.bounds.size.height - size.height;
            
            point = CGPointMake(x, y);
        }
            break;
            
        default:
            
            NSLog(@"[%s--第%d行]--[错误:进场方向参数传入错误!]",__func__,__LINE__);
            
            break;
    }


    /** 计算visibleView的frame */
    CGRect rect = CGRectMake(point.x, point.y, size.width, size.height);
    
    self.visibleView.frame = rect;

    self.defalutCenter = self.visibleView.center;
    
}


#pragma mark - 外部调用方法 : 出入场动画

/** 进场显示动画 */
- (void)showAnimationInWithCompletionBlock : (TFModalContentViewAnimationCompletionBlock)completionBlock
{
    /** 设置visibleView的动画效果 : 进场 */
    [self setVisibleViewTransformForAnimationIn];
    
    self.backgroundView.alpha = 0.0;
    
    [UIView animateWithDuration:TF_Animation_Show_Duration animations:^{
        
        self.visibleView.hidden = NO;
        self.visibleView.alpha = 1.0;
        self.visibleView.transform = CGAffineTransformIdentity;
        self.userInteractionEnabled = NO;
        
        self.backgroundView.alpha = TF_ModalView_Background_Alpha;
        
    } completion:^(BOOL finished) {
        
        
        self.userInteractionEnabled = YES;
        if (completionBlock)
            completionBlock();
        
    }];
    
    
}

/** 出场隐藏动画 */
- (void)showAnimationOutWithCompletionBlock : (TFModalContentViewAnimationCompletionBlock)completionBlock
{
    self.animationOutFlag = YES;
    
    self.visibleView.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:TF_Animation_Show_Duration animations:^{

        self.userInteractionEnabled = NO;
        [self setVisibleViewTransformForAnimationOut];
        
        self.backgroundView.alpha = 0.0;
    } completion:^(BOOL finished) {
        
        self.visibleView.hidden = YES;
        self.animationOutFlag = NO;
        self.userInteractionEnabled = YES;

        if (completionBlock)
            completionBlock();
        
       
        
    }];
    

}



#pragma mark - 内部计算方法

/** 设置visibleView的动画效果 : 进场 */
- (void)setVisibleViewTransformForAnimationIn
{
    switch (self.direction) {
        case TFModalViewControllerShowDirectionFromRight:
            
            self.visibleView.transform = CGAffineTransformMakeTranslation(self.visibleView.bounds.size.width, 0);
            
            break;
            
        case TFModalViewControllerShowDirectionFromLeft:
            self.visibleView.transform = CGAffineTransformMakeTranslation(0 - self.visibleView.bounds.size.width, 0);
            
            break;
            
        case TFModalViewControllerShowDirectionFromTop:
            self.visibleView.transform = CGAffineTransformMakeTranslation(0, 0 - self.visibleView.bounds.size.height);
            
            break;
            
        case TFModalViewControllerShowDirectionFromBottom:
            self.visibleView.transform = CGAffineTransformMakeTranslation(0, self.visibleView.bounds.size.height);
            
            break;
            
            
        default:
            
            break;
    }
}

/** 设置visibleView的动画效果 : 出场 */
- (void)setVisibleViewTransformForAnimationOut
{
    
    switch (self.direction) {
        case TFModalViewControllerShowDirectionFromRight:
            
            self.visibleView.transform = CGAffineTransformMakeTranslation(self.visibleView.bounds.size.width , 0);
            break;
            
        case TFModalViewControllerShowDirectionFromLeft:
            
            self.visibleView.transform = CGAffineTransformMakeTranslation(0 - self.visibleView.bounds.size.width, 0);
            break;
            
        case TFModalViewControllerShowDirectionFromTop:
            
            self.visibleView.transform = CGAffineTransformMakeTranslation(0, 0 - self.visibleView.bounds.size.height);
            break;
            
        case TFModalViewControllerShowDirectionFromBottom:
            
            self.visibleView.transform = CGAffineTransformMakeTranslation(0, self.visibleView.bounds.size.height);            
            break;
            
            
        default:
            
            break;
    }
}




/** 根据偏移量移动visbleView */
- (void)moveVisbleViewWithOffset : (CGPoint)offset
{
    //NSLog(@"--%@",NSStringFromCGPoint(offset));
    
    switch (self.direction) {
        case TFModalViewControllerShowDirectionFromLeft:
            if (CGRectGetMaxX(self.visibleView.frame) + offset.x >= self.visibleView.bounds.size.width)
                return;
            break;
            
        case TFModalViewControllerShowDirectionFromRight:
            if (CGRectGetMaxX(self.visibleView.frame) + offset.x <= self.bounds.size.width)
                return;
            break;
            
            
        case TFModalViewControllerShowDirectionFromTop:
            if (CGRectGetMaxY(self.visibleView.frame) + offset.y >= self.visibleView.bounds.size.height)
                return;
            break;
            
        case TFModalViewControllerShowDirectionFromBottom:
            if (CGRectGetMaxY(self.visibleView.frame) + offset.y <= self.bounds.size.height)
                return;
            break;
            
        default:
            return;
            break;
    }
    
    
    
    switch (self.direction) {
        case TFModalViewControllerShowDirectionFromLeft:
        case TFModalViewControllerShowDirectionFromRight:

            self.visibleView.center = CGPointMake(self.defalutCenter.x + offset.x, self.visibleView.center.y);

            break;
            
            
        case TFModalViewControllerShowDirectionFromTop:
        case TFModalViewControllerShowDirectionFromBottom:

            self.visibleView.center = CGPointMake(self.visibleView.center.x , self.defalutCenter.y + offset.y);

            break;
            
        default:
            return;
            break;
    }
    
    
    
}

/** 以动画形式隐藏或复位visbleView */
- (void)showAinmationForVisbleViewWithOffset : (CGPoint)offset
{
    
    
    CGFloat x = offset.x + self.visibleView.bounds.size.width * TF_ModalView_ShowHiddenAnimation_Scale;
    CGFloat y = offset.y + self.visibleView.bounds.size.height * TF_ModalView_ShowHiddenAnimation_Scale;
    /** 根据偏移量计算是否隐藏visbleView */
    if ((x < 0 && self.direction == TFModalViewControllerShowDirectionFromLeft) ||
        (x > (self.visibleView.bounds.size.width * TF_ModalView_ShowHiddenAnimation_Scale * 2 )&& self.direction == TFModalViewControllerShowDirectionFromRight) ||
        (y < 0 && self.direction == TFModalViewControllerShowDirectionFromTop) ||
        (y > (self.visibleView.bounds.size.height * TF_ModalView_ShowHiddenAnimation_Scale * 2 ) && self.direction == TFModalViewControllerShowDirectionFromBottom)
        )
    {
        [self.visbleController hiddenTFModalViewController];
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.userInteractionEnabled = NO;
            self.visibleView.center = self.defalutCenter;
        } completion:^(BOOL finished) {
            self.userInteractionEnabled = YES;
            
        }];
    }
    
    
}


#pragma mark - 添加手势


/** 添加蒙板手势 */
- (void)addMyRecognizerToBackgroundView
{
    /** 添加蒙板点击手势 */
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc] init];
    
    [self.backgroundView addGestureRecognizer:tapGR];
    
    [tapGR addTarget:self action:@selector(tapGestureRecognizerInBackgroundView:)];
    
    /** 添加蒙板拖拽手势 */
    UIPanGestureRecognizer * panGR = [[UIPanGestureRecognizer alloc] init];
    
    [self.backgroundView addGestureRecognizer:panGR];
    
    [panGR addTarget:self action:@selector(tapGestureRecognizerInBackgroundView:)];

    
}



/** 蒙板点击手势跟拖拽手势的触发方法 */
- (void)tapGestureRecognizerInBackgroundView : (UIGestureRecognizer *)gestureRecognizer
{

    /** 判断拖拽手势的状态 , 如果是changed或end就隐藏 , 其他状态则不处理 */
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]])
    {
        switch (gestureRecognizer.state) {

            case UIGestureRecognizerStateEnded:
            case UIGestureRecognizerStateChanged:
                if (self.animationOutFlag)
                    return;
                
                self.animationOutFlag = YES;
                break;

            default:
                return;
                break;
        }
    }
    
    /** 隐藏控制器 */
    [self.visbleController hiddenTFModalViewController];
    
}


/** 添加主view的手势 */
- (void)addMyRecognizerToSelf
{

    /** 添加蒙板拖拽手势 */
    UIPanGestureRecognizer * panGR = [[UIPanGestureRecognizer alloc] init];
    
    [self addGestureRecognizer:panGR];
    
    [panGR addTarget:self action:@selector(panGestureRecognizerInSelf:)];


}

/** 主view拽手势的触发方法 */
- (void)panGestureRecognizerInSelf : (UIPanGestureRecognizer *)panGR
{
    /** 只有从左边或右边展示出来的view才判断拖拽手势 */
    switch (self.direction) {
        case TFModalViewControllerShowDirectionFromLeft:
        case TFModalViewControllerShowDirectionFromRight:
        case TFModalViewControllerShowDirectionFromTop:
        case TFModalViewControllerShowDirectionFromBottom:
            break;
            
        default:
            return;
            break;
    }
    
    CGPoint point = [panGR translationInView:self];
    
    /** 根据手势的状态来移动visbleView */
    switch (panGR.state) {

        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
            self.animationOutFlag = YES;
            /** 根据偏移量移动visbleView */
            [self moveVisbleViewWithOffset:point];
            
            break;
        case UIGestureRecognizerStateEnded:
            self.animationOutFlag = NO;
            /** 根据偏移量以动画形式隐藏或复位visbleView */
            [self showAinmationForVisbleViewWithOffset:point];
            
            break;

            
        default:
            break;
    }
    
  

}




#pragma mark - 其他

- (void)dealloc
{
    /** 移除监听 */
    [self.visibleView removeObserver:self forKeyPath:@"center"];
    

    
    //NSLog(@"[%s--第%d行]--[modalView被销毁了! -- %@]",__func__,__LINE__,self);
}

@end




