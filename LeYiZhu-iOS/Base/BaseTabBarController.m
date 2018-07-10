//
//  BaseTabBarController.m
//  ZhiNengJiaju
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavController.h"
#import "LYZIndexController.h"
#import "LYZStayPlanViewController.h"
#import "LYZMineViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [UITabBar appearance].translucent = NO;
    [[UITabBar appearance] setTintColor:RGB(194, 158, 123)];
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                       RGB(194, 158, 123), NSForegroundColorAttributeName,nil]
//                                             forState:UIControlStateSelected];
//    
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                       RGB(69,71,76), NSForegroundColorAttributeName,nil]
//                                             forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                      LYZTheme_paleBrown, NSForegroundColorAttributeName,nil]
                                             forState:UIControlStateSelected];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor colorWithHexString:@"#9FA6B4"], NSForegroundColorAttributeName,nil]
                                             forState:UIControlStateNormal];
    
    [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
//    [[UITabBar appearance] setBackgroundImage:[[UIImage imageNamed:@"img_tab_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 1, 0, 0)]];
    
//    NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:14]};
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:LYZTheme_Font_Regular size:14],NSFontAttributeName, nil];
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes
                                                forState:UIControlStateNormal];
  
    [[UITabBar appearance] setBarTintColor:LYZTheme_NavTab_Color];
//
    LYZIndexController * mainVC = [[LYZIndexController alloc] init];
    BaseNavController *tabNavi1 = [[BaseNavController alloc] initWithRootViewController:mainVC];
    tabNavi1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"tabbar_icon_home_n"] selectedImage:[UIImage imageNamed:@"tabbar_icon_home_c"]];
    
//    MineViewController *mineVC = [[MineViewController alloc] init];
    LYZMineViewController *mineVC = [LYZMineViewController new];
     BaseNavController *tabNavi3 = [[BaseNavController alloc] initWithRootViewController:mineVC];
    tabNavi3.title = @"我的";
    
    tabNavi3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"tabbar_icon_me_n"] selectedImage:[UIImage imageNamed:@"tabbar_icon_me_c"]];
    
    
//    CheckInInfoViewController * checkInVC = [[CheckInInfoViewController alloc] init];
     LYZStayPlanViewController * checkInVC = [[LYZStayPlanViewController alloc] init];
    BaseNavController * tabNavi2 = [[BaseNavController alloc] initWithRootViewController:checkInVC];
    tabNavi2.title = @"入住";
    tabNavi2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"入住" image:[UIImage imageNamed:@"tabbar_icon_bed_n"] selectedImage:[UIImage imageNamed:@"tabbar_icon_bed_c"]];
    self.viewControllers = @[tabNavi1,tabNavi2,tabNavi3];
    //防止标题栏太长，跳到下一个页面的back文字太长了，而导致标题栏偏移
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    
    if (self.selectedIndex != index) {
        [self playSound];//点击时音效
        [self animationWithIndex:index];
    }
    
}

// 动画
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
    self.selectedIndex = index;
    
}

-(void) playSound{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"like" ofType:@"caf"];
    SystemSoundID soundID;
    NSURL *soundURL = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL,&soundID);
    AudioServicesPlaySystemSound(soundID);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
