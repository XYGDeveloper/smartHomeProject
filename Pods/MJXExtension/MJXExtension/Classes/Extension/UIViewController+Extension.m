//
//  UIViewController+Extension.m
//  基础框架
//
//  Created by MJX on 2017/7/5.
//  Copyright © 2017年 ShangTong. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

//MARK: -- 隐藏导航栏
- (void)hiddenNavigationBar{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

//MARK: -- 显示导航栏
- (void)showNavigationBar{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


//MARK: -- 隐藏标签栏
- (void)hiddenTabBar{
   self.tabBarController.tabBar.hidden = YES;
}

//MARK: -- 显示标签栏
- (void)showTabBar{
    self.tabBarController.tabBar.hidden = NO;
}

//MARK: -- 设置标题
- (void)setNavigationBarTitle:(NSString *)text{
    
    UILabel * titleView=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 40)];
    [titleView setText:text];
    [titleView setTextColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:1]];
    [titleView setFont:[UIFont systemFontOfSize:16]];
    titleView.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleView;
}

//MARK: -- 设置返回按钮
- (void)setBackImageWithName:(NSString *)name{
    
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.frame = CGRectMake(0, 0, 20, 20);
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.userInteractionEnabled = YES;
    imageview.image = [UIImage imageNamed:name];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:imageview];
    self.navigationItem.leftBarButtonItem = btnItem;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBack)];
    [imageview addGestureRecognizer:tap];
    
}


//MARK: -- 设置右侧自定义图(包括按钮)
- (void)setRightView:(UIView *)customView{
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    self.navigationItem.rightBarButtonItem = btnItem;
}

//MARK: -- 设置左侧自定义图(包括按钮)
- (void)setLeftView:(UIView *)customView{
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    self.navigationItem.leftBarButtonItem = btnItem;
}

- (void)handleBack{
    
    if (self.navigationController.viewControllers.count > 0) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


//MARK: -- 设置右侧Items
- (void)setRightWithItems:(NSArray <UIBarButtonItem *>*)items{
    self.navigationItem.rightBarButtonItems = items;
}

@end
