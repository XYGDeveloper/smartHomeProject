//
//  UIViewController+BarButton.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "UIViewController+BarButton.h"
#import "UIButton+LYZLoginButton.h"

#define  SYSTEM_VERSION_LESS_THAN(version) (([[[UIDevice currentDevice] systemVersion] floatValue] < [version floatValue]) ? YES : NO)

@implementation UIViewController (BarButton)

- (void)addLeftBarButtonWithImage:(UIImage *)image action:(SEL)action needLogin:(BOOL)needLogin{
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake(0, 0, 44, 44);
    firstButton.needLogin = needLogin;
    [firstButton setImage:image forState:UIControlStateNormal];
    [firstButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (!SYSTEM_VERSION_LESS_THAN(@"11")) {
        firstButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
        [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5 *kScreenWidth /375.0,0,0)];
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:firstButton];
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    }else{
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:firstButton];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceItem.width = - 20;
        self.navigationItem.leftBarButtonItems = @[spaceItem,leftBarButtonItem];
    }
}

- (void)addLeftBarButtonWithImage:(UIImage *)image action:(SEL)action{
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake(0, 0, 44, 44);
    [firstButton setImage:image forState:UIControlStateNormal];
    [firstButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (!SYSTEM_VERSION_LESS_THAN(@"11")) {
        firstButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
        [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5 *kScreenWidth /375.0,0,0)];
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:firstButton];
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    }else{
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:firstButton];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceItem.width = - 20;
        self.navigationItem.leftBarButtonItems = @[spaceItem,leftBarButtonItem];
    }
}

//右侧一个图片按钮的情况
- (void)addRightBarButtonWithFirstImage:(UIImage *)firstImage action:(SEL)action{
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    firstButton.frame = CGRectMake(0, 5, 64, 44);
    
    [firstButton setImage:firstImage forState:UIControlStateNormal];
    
    [firstButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (!SYSTEM_VERSION_LESS_THAN(@"11")) {
        
        firstButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
        [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0,0,0, -0 *kScreenWidth /375.0)];
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:firstButton];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    }else{
       UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:firstButton];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceItem.width = - 20;
        self.navigationItem.rightBarButtonItems = @[spaceItem,rightBarButtonItem];
    }
}

//右侧为文字item的情况
- (void)addRightBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action{
    UIButton *rightbBarButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,88,44)];
    
    [rightbBarButton setTitle:itemTitle forState:(UIControlStateNormal)];
    
    [rightbBarButton setTitleColor:LYZTheme_paleBrown forState:(UIControlStateNormal)];
    
    rightbBarButton.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    
    [rightbBarButton addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    if (!SYSTEM_VERSION_LESS_THAN(@"11")) {
        
        rightbBarButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
        
        [rightbBarButton setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0, -5 * kScreenWidth/375.0)];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightbBarButton];
        
    }else{
        UIBarButtonItem *rightBarButtonItem =  [[UIBarButtonItem alloc]initWithCustomView:rightbBarButton];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceItem.width = - 20;
        self.navigationItem.rightBarButtonItems = @[spaceItem,rightBarButtonItem];
    }
    
    
}

//左侧为文字item的情况
- (void)addLeftBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action

{
    
    UIButton *leftbBarButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,44,44)];
    
    [leftbBarButton setTitle:itemTitle forState:(UIControlStateNormal)];
    
    [leftbBarButton setTitleColor:LYZTheme_paleBrown forState:(UIControlStateNormal)];
    
    leftbBarButton.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    
    [leftbBarButton addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    if (!SYSTEM_VERSION_LESS_THAN(@"11")) {
        
        leftbBarButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
        
        [leftbBarButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -5  *kScreenWidth/375.0,0,0)];
        
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftbBarButton];
    
}


//右侧两个图片item的情况
- (void)addRightTwoBarButtonsWithFirstImage:(UIImage *)firstImage firstAction:(SEL)firstAction secondImage:(UIImage *)secondImage secondAction:(SEL)secondAction

{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0,80,44)];
    
    view.backgroundColor = [UIColor clearColor];
    
    
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    firstButton.frame = CGRectMake(44, 6, 30, 30);
    
    [firstButton setImage:firstImage forState:UIControlStateNormal];
    
    [firstButton addTarget:self action:firstAction forControlEvents:UIControlEventTouchUpInside];
    
    if (!SYSTEM_VERSION_LESS_THAN(@"11")) {
        
        firstButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
        
        [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0,0,0, -5 * kScreenWidth/375.0)];
        
    }
    
    [view addSubview:firstButton];
    
    
    
    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    secondButton.frame = CGRectMake(6, 6, 30, 30);
    
    [secondButton setImage:secondImage forState:UIControlStateNormal];
    
    [secondButton addTarget:self action:secondAction forControlEvents:UIControlEventTouchUpInside];
    
    if (!SYSTEM_VERSION_LESS_THAN(@"11")) {
        
        secondButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
        
        [secondButton setImageEdgeInsets:UIEdgeInsetsMake(0,0,0, -5 * kScreenWidth/375.0)];
        
    }
    
    [view addSubview:secondButton];
    
    
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}

@end
