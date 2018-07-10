//
//  LYZGuidViewController.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/1/20.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZGuidViewController.h"

@interface LYZGuidViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation LYZGuidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (instancetype)shareXTGuideVC
{
    static LYZGuidViewController *x = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        x = [[LYZGuidViewController alloc] init];
    });
    return x;
}

- (void)initWithXTGuideView:(NSArray *)images
{
    UIScrollView *gui = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    gui.pagingEnabled = YES;
    // 隐藏滑动条
    gui.showsHorizontalScrollIndicator = NO;
    gui.showsVerticalScrollIndicator = NO;
    // 取消反弹
    gui.bounces = NO;
    for (NSInteger i = 0; i < images.count; i ++) {
        [gui addSubview:({
            self.btnEnter = [UIButton buttonWithType:UIButtonTypeCustom];
            self.btnEnter.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            [self.btnEnter setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];;
            self.btnEnter;
        })];
        
        [self.btnEnter addSubview:({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"点击进入" forState:UIControlStateNormal];
            btn.frame = CGRectMake(SCREEN_WIDTH * i, SCREEN_HEIGHT - 60, 100, 40);
            btn.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 60);
            btn.backgroundColor = [UIColor lightGrayColor];
            [btn addTarget:self action:@selector(clickEnter) forControlEvents:UIControlEventTouchUpInside];
            btn;
        })];
    }
    gui.contentSize = CGSizeMake(SCREEN_WIDTH * images.count, 0);
    [self.view addSubview:gui];
    // pageControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT / 2, 30)];
    self.pageControl.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 95);
    [self.view addSubview:self.pageControl];
    self.pageControl.numberOfPages = images.count;
    
    
}


- (void)clickEnter
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(click)]) {
        [self.delegate click];
    }
}

- (BOOL)isShow
{
    // 读取版本信息
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ScrollerView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x / SCREEN_WIDTH;
}


@end
