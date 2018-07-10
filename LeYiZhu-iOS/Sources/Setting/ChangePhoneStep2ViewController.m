//
//  ChangePhoneStep2ViewController.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/10.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "ChangePhoneStep2ViewController.h"
#import "LoginManager.h"
#import "Public+JGHUD.h"
#import "ChangePhoneCompleteView.h"
#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationSpring.h"
#import "ThirdLoginInfoModel.h"
#import "bindByPhoneResponse.h"
#import "GCD.h"
#import <Reachability.h>
#import "Masonry.h"
#import "User.h"
@interface ChangePhoneStep2ViewController ()

@property (nonatomic ,strong) UITextField *phoneTextField;

@property (nonatomic, strong) UITextField *captchaTextField;

@property (nonatomic, strong) UIButton *captchaBtn;
@property (nonatomic,assign)BOOL flag;
@property (nonatomic,strong)Reachability *reach;

@end

@implementation ChangePhoneStep2ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = (int)self.type ? @"绑定手机":@"修改手机号";
    
    [self setupUI];
    
    self.reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [self.reach startNotifier];
    
    
}

- (void) reachabilityChanged: (NSNotification*)note {
    Reachability * reach = [note object];
    
    if(![reach isReachable])
    {
        // self.optionVarButton.enabled = NO;
        self.flag = YES;
    }
    
}

-(void)setupUI{

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView * phoneImageView = [[UIImageView alloc] init];
    phoneImageView.contentMode = UIViewContentModeScaleToFill;
    phoneImageView.image = [UIImage imageNamed:@"Login_telephone_icon"];
    [self.view addSubview:phoneImageView];
    [phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    self.phoneTextField = [[UITextField alloc] init];
    self.phoneTextField.textAlignment = NSTextAlignmentLeft;
    self.phoneTextField.clearsOnBeginEditing = YES;
    self.phoneTextField.placeholder = (int)self.type ? @"输入需要绑定的手机号":@"输入新手机号";
    [self.view addSubview:self.phoneTextField];
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneImageView.mas_right).mas_equalTo(10);
        make.centerY.mas_equalTo(phoneImageView.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH- 40- 10-15-120);
        make.height.mas_equalTo(40);
    }];
    
    UIView *vLine = [[UIView alloc] init];
    vLine.backgroundColor = kLineColor;
    [self.view addSubview:vLine];
    
    [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneTextField.mas_right);
       make.centerY.mas_equalTo(phoneImageView.mas_centerY);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(40);
    }];
    _captchaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_captchaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _captchaBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    [_captchaBtn setTitleColor:LYZTheme_paleBrown forState:UIControlStateNormal];
    [_captchaBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_captchaBtn];
    
    [self.captchaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.phoneTextField.mas_centerY);
        make.left.mas_equalTo(self.phoneTextField.mas_right).mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right).mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = kLineColor;
    [self.view addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(1);
        
    }];
    
    //
    UIImageView * varImageView = [[UIImageView alloc] init];
    varImageView.contentMode = UIViewContentModeScaleToFill;
    varImageView.image = [UIImage imageNamed:@"Login_varcode_pic"];
    [self.view addSubview:varImageView];
    [varImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).mas_equalTo(25);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    _captchaTextField = [[UITextField alloc] init];
    _captchaTextField.textAlignment = NSTextAlignmentLeft;
    _captchaTextField.clearsOnBeginEditing = YES;
    _captchaTextField.placeholder = @"输入验证码";
    [self.view addSubview:_captchaTextField];
    
    [self.captchaTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(varImageView.mas_right).mas_equalTo(10);
        make.centerY.mas_equalTo(varImageView.mas_centerY);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    
    UIView * lineView2 = [[UIView alloc] init];
      lineView2.backgroundColor = kLineColor;
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.captchaTextField.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(1);
    }];
    
    UIButton * completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [completeBtn setTitle:@"绑定" forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(completeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:completeBtn];
    completeBtn.backgroundColor = LYZTheme_paleBrown;
    completeBtn.layer.cornerRadius = 4;
    
    [completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView2.mas_bottom).mas_equalTo(40);
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"为了您的账户安全，请绑定手机";
    label.font = [UIFont fontWithName:LYZTheme_Font_Medium size:14.0f];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:153/255.0];
    label.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnClick:(UIButton *)sender {
   
    
    NSString *phone = self.phoneTextField.text;
    
    if(phone.length == 0){
        [Public showJGHUDWhenError:self.view msg:@"请填写手机号!"];
        return;
    }
   
    if(phone.length < 11 || phone.length > 11){
        [Public showJGHUDWhenError:self.view msg:@"手机号码输入不正确"];
        return;
    }
    if (![self.reach isReachable]) {
        [Public showMessageWithHUD:self.view message:@"当前网络没有连接，请检查网络"];
        return;
        
    }
    if (self.flag == YES) {
        self.captchaBtn.enabled = NO;
        [Public showMessageWithHUD:self.view message:@"当前网络没有连接，请检查网络"];
        return;
        
    }
    [_captchaTextField becomeFirstResponder];
    [[LYZNetWorkEngine sharedInstance] userGetCaptcha:phone versioncode:VersionCode devicenum:DeviceNum fromtype:FromType block:^(int event, id object) {
        
        if(event){
            
           [Public showMessageWithHUD:self.view message:@"验证码发送成功！"];
            
        }else{
            
           [Public showMessageWithHUD:self.view message:@"验证码发送失败！"];
            
        }
    }];

    
    __block int timeout=59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                [_captchaBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                [_captchaBtn setTitleColor:LYZTheme_paleBrown forState:UIControlStateNormal];
                _captchaBtn.userInteractionEnabled = YES;
                
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            
//            int seconds = timeout % 59;
            int seconds = timeout;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                LYLog(@"____%@",strTime);
                 [_captchaBtn setTitleColor:LYZTheme_BrownishGreyFontColor forState:UIControlStateNormal ];
                [_captchaBtn setTitle:[NSString stringWithFormat:@"%@秒后可重发",strTime] forState:UIControlStateNormal];
                _captchaBtn.userInteractionEnabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
    
}


-(void)completeBtnClick:(id)sender{
    
    

    NSString *phoneNum = self.phoneTextField.text;
    NSString *captcha = self.captchaTextField.text;
    
    
    if(phoneNum.length == 0){
        [Public showJGHUDWhenError:self.view msg:@"请填写手机号!"];
        return;
    }
    if(phoneNum.length < 11 || phoneNum.length > 11){
        [Public showJGHUDWhenError:self.view msg:@"手机号码输入不正确"];
        return;
    }
    
    if(captcha.length == 0){
        [Public showJGHUDWhenError:self.view msg:@"请填写正确的验证码!"];
        return;
    }
    
    JGProgressHUD *hud = [Public hudWhenRequest];
    [hud showInView:self.view animated:YES];
    
    
    if (self.type == changeType) {
        User* userInfo =  [LoginManager instance].userInfo;
        [[LYZNetWorkEngine sharedInstance]  updatePhoneWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:userInfo.appUserID phone:phoneNum captcha:captcha block:^(int event, id object) {
            [hud dismissAnimated:YES];
            if (event == 1) {
                [[LoginManager instance] logoutWithblock:^(int event, id object) {
                   
                    if (event == 1) {
                        
                        
                        ChangePhoneCompleteView * view = [[ChangePhoneCompleteView alloc] initWithFrame:CGRectMake(0, 0, 344, 262)];
                        view.parentVC = self;
                        view.phoneNum = phoneNum;
                        view.layer.cornerRadius = 8.0;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [self lew_presentPopupView:view animation:[LewPopupViewAnimationSpring new] dismissed:^{
                                LYLog(@"动画结束");
                            }];
                        });
                    }else{

                        NSString *msg = [NSString  stringWithFormat:@"%@",object];
                        [Public showJGHUDWhenError:self.view msg:msg];
                        LYLog(@"ERROR IS ----->>>>>%@",object);
                    }
                }];
                
            }else{
                
                if (self.flag == YES) {
                    [Public showJGHUDWhenError:self.view msg:@"当前网络没有连接，请检查网络"];
                    return;
                }
                NSString *msg = [NSString  stringWithFormat:@"%@",object];
                [Public showJGHUDWhenError:self.view msg:msg];
                LYLog(@"ERROR IS ----->>>>>%@",object);
                
            }
            
        }];
        
    }else{
        
        [[LYZNetWorkEngine sharedInstance] bindPhone:VersionCode devicenum:DeviceNum fromtype:FromType phone:phoneNum captcha:captcha thirdID:self.infoModel.thirdID type:self.infoModel.type nickName:self.infoModel.nickName facePath:self.infoModel.facePath block:^(int event, id object) {
             [hud dismissAnimated:YES];
            if (event == 1) {
                
                [Public showJGHUDWhenSuccess:self.view msg:@"绑定成功"];
                bindByPhoneResponse *response = (bindByPhoneResponse *)object;
                UserInfo *user = response.userInfo;
                [[LoginManager instance] saveUserInfo:user];
                
                [GCDQueue executeInMainQueue:^{
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                } afterDelaySecs:1.0];
                
            }else{
                
                NSString *msg = [NSString  stringWithFormat:@"%@",object];
                [Public showJGHUDWhenError:self.view msg:msg];
            }
        }];
    }
    
    
}

@end
