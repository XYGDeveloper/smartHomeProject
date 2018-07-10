//
//  ResetPswViewController.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/12.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "ResetPswViewController.h"
#import "LoginManager.h"
#import "UserInfo.h"
#import "Public+JGHUD.h"

@interface ResetPswViewController ()

@property (nonatomic,strong) UITextField *originTextField;

@property (nonatomic ,strong) UITextField *nTextField;


@end

@implementation ResetPswViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"修改密码";
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

-(void)setUpUI{
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    
    UILabel * originPswLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
    originPswLabel.textAlignment = NSTextAlignmentCenter;
    originPswLabel.font = [UIFont systemFontOfSize:15];
    originPswLabel.textColor = [UIColor blackColor];
    originPswLabel.text = @"原密码";
    [self.view addSubview:originPswLabel];
    
    _originTextField = [[UITextField alloc] initWithFrame:CGRectMake(originPswLabel.right, originPswLabel.y, 135, originPswLabel.height)];
    _originTextField.clearsOnBeginEditing = YES;
    _originTextField.placeholder = @"输入原密码";
    _originTextField.secureTextEntry = YES;
    [self.view addSubview:_originTextField];
    
    
    UIButton *showBtn_1 = [UIButton buttonWithType:UIButtonTypeCustom];
    showBtn_1.frame = CGRectMake(SCREEN_WIDTH - 20 - 30, originPswLabel.y + 15, 30, 30);
    [showBtn_1 setImage:[UIImage imageNamed:@"btn_nosee_n"] forState:UIControlStateNormal];
    [showBtn_1 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showBtn_1];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, originPswLabel.bottom, SCREEN_WIDTH, 15)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#E8E8E8"];
    [self.view addSubview:lineView];
    
    UILabel * nowPswLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, lineView.bottom, 100, 60)];
    nowPswLabel.textAlignment = NSTextAlignmentCenter;
    nowPswLabel.font = [UIFont systemFontOfSize:15];
    nowPswLabel.textColor = [UIColor blackColor];
    nowPswLabel.text = @"新密码";
    [self.view addSubview:nowPswLabel];
    
    _nTextField = [[UITextField alloc] initWithFrame:CGRectMake(nowPswLabel.right, nowPswLabel.y, 135, nowPswLabel.height)];
    _nTextField.clearsOnBeginEditing = YES;
    _nTextField.placeholder = @"输入新密码";
    _nTextField.secureTextEntry = YES;
    [self.view addSubview:_nTextField];
    
    
    UIButton *showBtn_2 = [UIButton buttonWithType:UIButtonTypeCustom];
    showBtn_2.frame = CGRectMake(SCREEN_WIDTH - 20 - 30, nowPswLabel.y + 15, 30, 30);
    [showBtn_2 setImage:[UIImage imageNamed:@"btn_nosee_n"] forState:UIControlStateNormal];
    [showBtn_2 addTarget:self action:@selector(btn2Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showBtn_2];
    
    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, nowPswLabel.bottom, SCREEN_WIDTH, 1)];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"#E8E8E8"];
    [self.view addSubview:lineView2];
    
    UIButton * commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    commitBtn.backgroundColor = [UIColor colorWithHexString:@"#f2bb12"];
    [commitBtn setTitle:@"确定" forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
    
}

-(void)btn1Click:(id)sender{
    UIButton * btn = (UIButton *)sender;
    if (_originTextField.secureTextEntry) {
        [btn setImage:[UIImage imageNamed:@"btn_nosee_c"] forState:UIControlStateNormal];
        _originTextField.secureTextEntry = NO;
    }else{
        [btn setImage:[UIImage imageNamed:@"btn_nosee_n"] forState:UIControlStateNormal];
        _originTextField.secureTextEntry = YES;
    }
}


-(void)btn2Click:(id)sender{
    UIButton * btn = (UIButton *)sender;
    if (_nTextField.secureTextEntry) {
        [btn setImage:[UIImage imageNamed:@"btn_nosee_c"] forState:UIControlStateNormal];
        _nTextField.secureTextEntry = NO;
    }else{
        [btn setImage:[UIImage imageNamed:@"btn_nosee_n"] forState:UIControlStateNormal];
        _nTextField.secureTextEntry = YES;
    }
}


-(BOOL)isIncludeSpecialCharact: (NSString *)str {
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}


-(void)commitBtnClick:(id)sender{

    NSString *origin = self.originTextField.text;
    NSString *now = self.nTextField.text;
    
    
    if(origin.length == 0){
        [Public showJGHUDWhenError:self.view msg:@"请填写原密码"];
        return;
    }
    if(now.length == 0){
        [Public showJGHUDWhenError:self.view msg:@"请填写新密码"];
        return;
    }
    
    if ([self isIncludeSpecialCharact:now]) {
        [Public showJGHUDWhenError:self.view msg:@"密码由6-18位的字母或数字"];
        return;
    }
    
    if (now.length < 6 || now.length > 18) {
        [Public showJGHUDWhenError:self.view msg:@"密码由6-18位的字母或数字"];
        return;
    }
    
    
    NSString *userId = [LoginManager instance].appUserID;
    
    JGProgressHUD *hud = [Public hudWhenRequest];
    [hud showInView:self.view animated:YES];
    
   [[LYZNetWorkEngine sharedInstance] updatePasswordWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:userId oldPsw:origin npsw:now block:^(int event, id object) {
       if (event == 1) {
           [[LoginManager instance] logoutWithblock:^(int event, id object) {
                 [hud dismissAnimated:YES];
               if (event == 1) {
                   JGProgressHUD *hud =  [Public hudWhenSuccessWithMsg:@"修改成功"];
                   [hud showInView:self.view];
                   
                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       [hud dismissAnimated:YES];
                   });
                   
                  [[LoginManager instance] userLogin];
                   
               }else{
                   NSString *msg = [NSString  stringWithFormat:@"%@",object];
                   [Public showJGHUDWhenError:self.view msg:msg];
               }
           }];

       }else{
           NSString *msg = [NSString  stringWithFormat:@"%@",object];
           [Public showJGHUDWhenError:self.view msg:msg];
       }
   }];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
