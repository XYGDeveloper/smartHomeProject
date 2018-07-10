//
//  TFModalViewController.m
//  20141109-01TFModalViewController框架
//
//  Created by btz-mac on 14-11-9.
//  Copyright (c) 2014年 朱佰通. All rights reserved.
//

#import "TFModalViewController.h"
#import "objc/runtime.h"
#import "TFModalContentView.h"


static NSString * const TFModalViewKey = @"TFModalView_Key";

@interface TFModalViewController ()

@end

@implementation TFModalViewController


#pragma 初始化 - 单例 模式

static TFModalViewController * _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });

    return _instance;
}

+ (instancetype)sharedModalViewController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}


- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}


#pragma mark - 初始化 方法

- (instancetype)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
        
        if (_instance)
        {
            _instance.view.backgroundColor = [UIColor clearColor];
            //_instance.view.alpha = 0.0;
            
        }
    });

    return _instance;
}


#pragma mark - 界面加载方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark - 外部调用方法


/**
 *  弹出一个控制器在当前的控制器之上. [scale : 弹出的比例]-[direction : 弹出的方向]
 *
 *  @param controller 要显示的控制器
 *  @param scale      显示比例 , 取值范围 (0.0~1.0] ,超出范围的值会以默认值0.75的比例显示.
 *  @param direction  弹出方向 , 见枚举值TFModalViewControllerShowDirection
 *  @param superViewController  需要弹出界面的父级控制器
 */
- (void)showModalViewWithController : (UIViewController *)controller AndShowScale : (CGFloat)scale AndShowDirection : (TFModalViewControllerShowDirection)direction FromSuperViewController:(UIViewController *)superViewController WithShowCompletionBlock:(TFModalViewControllerShowCompletionBlock)completionBlock
{
 
    /** 参数边界值判断 */
    if (scale <=0 || scale > 1 )
        scale = ModalView_ShowScale_Default;
    
    /** 判断传入的控制器 */
    if (controller == nil || !([controller isKindOfClass:[UIViewController class]]))
    {
        NSLog(@"[%s--第%d行]--[错误:传入的控制器不能为空或不是控制器类型!]",__func__,__LINE__);
        return;
    }
    
    /** 判断传入的控制器是否是之前经过本方法弹出的未被收回的控制器 */
    TFModalContentView * lastModalView = objc_getAssociatedObject(controller, (__bridge const void *)(TFModalViewKey));
    if (lastModalView)
    {
        NSLog(@"[%s--第%d行]--[错误:方法使用错误>>请不要将同一个控制器show两次!在第二次show之前先hidden第一次的弹出.]",__func__,__LINE__);
        return;
    }
    
    /** 创建容器view 并将要show的控制器的view加到上面 */
    TFModalContentView * modalView = [[TFModalContentView alloc] initWithVisibleView:controller.view AndScale:scale AndDirection:direction];
    
    /** 给要show的控制器添加容器view这个属性 */
    objc_setAssociatedObject(controller, (__bridge const void *)(TFModalViewKey), modalView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    modalView.visbleController = controller;

    /** 如果要添加到window上 , 则做这一步判断 */
    if (superViewController == self)
    {
        UIWindow * lastWindow = [[UIApplication sharedApplication].windows lastObject];
        [lastWindow addSubview:self.view];
        self.view.frame = lastWindow.bounds;

    }

        /** 将show的控制器添加到其主控制器上 */
        [superViewController addChildViewController:controller];
        [controller beginAppearanceTransition:YES animated:YES];//确保viewwillappear 调用  ---> 超级大坑： 不加此方法子控制前的viewwillappear 不会执行
    
        [superViewController.view addSubview:modalView];
        /** 设置frame跟主控制一样 */
        modalView.frame = superViewController.view.bounds;

    
    
    /** 在show的过程中 , 禁止用户界面交互 */
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = NO;

    /** 开始动画showView */
    [modalView showAnimationInWithCompletionBlock:^{
        
        [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;

        if (completionBlock)
            completionBlock();
    }];

}


/** 隐藏弹出的控制器 , 当界面完全隐藏之后执行block内的代码 */
- (void)hiddenModalViewController : (UIViewController *)controller WithHiddenCompletionBlock : (TFModalViewControllerHiddenCompletionBlock)completionBlock
{
    TFModalContentView * modalContentView = objc_getAssociatedObject(controller, (__bridge const void *)(TFModalViewKey));
   
    if (!modalContentView)
    {
        NSLog(@"[%s--第%d行]--[错误:该控制器不是经过[self showTFModalView...]系列方法弹出的 , 无法用该方法隐藏!]",__func__,__LINE__);
        return;
    }
    
    /** 在隐藏界面过程中 , 禁止用户交互 */
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = NO;
    [modalContentView showAnimationOutWithCompletionBlock:^{
        [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;

        if (completionBlock)
            completionBlock();
        
        /** 移除添加的属性 */
        objc_removeAssociatedObjects(controller);
        
        /** 如果这个view是添加到window上的 , 则需要做这一步判断处理 */
        if (modalContentView.superview == self.view && self.childViewControllers.count <= 1)
        {
            [self.view removeFromSuperview];
        }
        
        /** 销毁弹出的控制器 */
        [modalContentView removeFromSuperview];
        [controller removeFromParentViewController];

    }];
    
    
}





@end
