//
//  BaseNavController.m
//  ZhiNengJiaju
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaseNavController.h"

@interface BaseNavController ()

@end

@implementation BaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage =[UIImage new];
//    self.navigationBar.clipsToBounds = YES;
//    self.navigationBar.barStyle = UIBarStyleBlack;
//    self.navigationBar.translucent = YES;
    
    [[UINavigationBar appearance] setBarTintColor:LYZTheme_NavTab_Color];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    //导航栏返回箭头 没有文字
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault]; // Deprecated ios 11
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
//    UIImage *backButtonImage = [ resizableImageWithCapInsets: UIEdgeInsetsMake(0, 25, 0, 0)];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"icon_returned"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIImage *backButtonImage = [[UIImage imageNamed:@"icon_returned"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationBar.backIndicatorImage = backButtonImage;
    self.navigationBar.backIndicatorTransitionMaskImage = backButtonImage;


//    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:NavBarColor] forBarMetrics:UIBarMetricsDefault];
//    self.navigationBar.translucent = NO;
    
//    UIImage * leftImg = [[UIImage imageNamed:@"icon_returned"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem * leftNavItem = [[UIBarButtonItem alloc] initWithImage:leftImg style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
//    self.navigationItem.leftBarButtonItem = leftNavItem;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil]; 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back:(id)sender
{
    [self popViewControllerAnimated:YES];
}




@end
