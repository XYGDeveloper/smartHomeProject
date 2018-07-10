//
//  ExchangeCouponViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/16.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "ExchangeCouponViewController.h"
#import "Public+JGHUD.h"

@interface ExchangeCouponViewController ()

@property (nonatomic, strong) UITextField *exchangeTF;

@end

@implementation ExchangeCouponViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    self.title = @"优惠券兑换";
    [self UIConfig];
}

-(void)UIConfig{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 20, SCREEN_WIDTH -2*DefaultLeftSpace, 50)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5.0f;
    bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    bgView.layer.shadowOffset = CGSizeMake(2, 4);
    [self.view addSubview:bgView];
    
    self.exchangeTF = [[UITextField alloc] initWithFrame:bgView.bounds];
    self.exchangeTF.backgroundColor = [UIColor clearColor];
    self.exchangeTF.placeholder = @"请输入活动关键词或兑换码";
    self.exchangeTF.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:self.exchangeTF];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(DefaultLeftSpace, bgView.bottom + 25, SCREEN_WIDTH - 2* DefaultLeftSpace, 42);
    shareBtn.layer.cornerRadius = 5.0f;
    shareBtn.backgroundColor = LYZTheme_paleBrown;
    [shareBtn setTitle:@"兑换" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:17];
    [shareBtn addTarget:self action:@selector(exchange:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
}

-(void)exchange:(id)sender{
    [self.exchangeTF resignFirstResponder];
    NSString *code = self.exchangeTF.text;
    if (code.length == 0) {
        [Public showJGHUDWhenError:self.view msg:@"兑换码不能为空"];
        return;
    }
    
    [[LYZNetWorkEngine sharedInstance] exchangeCouponWithCode:code block:^(int event, id object) {
        if (event == 1) {
            [Public showJGHUDWhenSuccess:self.view msg:@"兑换成功"];
        }else{
            [Public showJGHUDWhenError:self.view msg:object];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
