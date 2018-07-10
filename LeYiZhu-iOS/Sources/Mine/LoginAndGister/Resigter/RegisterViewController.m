//
//  RegisterViewController.m
//  denglu
//
//  Created by xyg on 2017/3/21.
//  Copyright © 2017年 xyg. All rights reserved.
//

#import "RegisterViewController.h"
#import "Public+JGHUD.h"
#import "GCD.h"
#import "LoginManager.h"
#import <Reachability.h>
@interface RegisterViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *telephone;

@property (weak, nonatomic) IBOutlet UIButton *optionVarButton;

@property (weak, nonatomic) IBOutlet UITextField *varCode;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (nonatomic , strong) NSTimer *codeTimer;
@property (nonatomic , strong) Reachability *reach;
@property (nonatomic,assign)BOOL flag;

@property (nonatomic , assign) int count ;

@end

@implementation RegisterViewController



- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    self.telephone.delegate = self;
    self.telephone.keyboardType = UIKeyboardTypeNumberPad;
    self.varCode.delegate = self;
    self.password.delegate  =self;
    self.password.secureTextEntry = YES;
    self.varCode.keyboardType = UIKeyboardTypeNumberPad;
    self.registerButton.layer.cornerRadius = 6;
    self.telephone.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.varCode.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.password.clearButtonMode = UITextFieldViewModeWhileEditing;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];
    return YES;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [self.view endEditing:YES];
    
    
}


- (IBAction)GetVarcodeAAction:(id)sender {
    
    
    if(self.telephone.text.length == 0){
        [Public showJGHUDWhenError:self.view msg:@"手机号不能为空!"];
        return;
    }
    
    if(self.telephone.text.length < 11 || self.telephone.text.length > 11){
        [Public showJGHUDWhenError:self.view msg:@"手机号码输入不正确"];
        return;
    }
    
    if (![self.reach isReachable]) {
           [Public showMessageWithHUD:self.view message:@"当前网络没有连接，请检查网络"];
        return;
        
    }
    
    
    if (self.flag == YES) {
        
        self.optionVarButton.enabled = NO;
        [Public showMessageWithHUD:self.view message:@"当前网络没有连接，请检查网络"];
        return;
        
    }
    self.count = 60.0;
    self.optionVarButton.enabled = NO;
    self.codeTimer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(timerClick:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.codeTimer forMode:NSRunLoopCommonModes];
    [self.codeTimer fire];
  
    [[LYZNetWorkEngine sharedInstance]userGetCaptcha:self.telephone.text versioncode:VersionCode devicenum:DeviceNum fromtype:FromType block:^(int event, id object) {
        
        if(event){
            
            [Public showMessageWithHUD:self.view message:@"验证码发送成功！"];
            
        }else{
            
            [Public showMessageWithHUD:self.view message:@"验证码发送失败！"];
        }
    }];

    
}

- (void) reachabilityChanged: (NSNotification*)note {
    Reachability * reach = [note object];
    
    if(![reach isReachable])
    {
       // self.optionVarButton.enabled = NO;
        self.flag = YES;
    }
    
}



- (void)timerClick:(NSTimer *)timer
{
    if(self.count == 0){
        NSString *str = @"获取验证码";
        [self.optionVarButton setTitle:str forState:UIControlStateNormal];
        
        [self.codeTimer invalidate];
        self.codeTimer = nil;
        self.optionVarButton.enabled = YES;
        self.count = 60;
    }else{
        NSString *str = [NSString stringWithFormat:@"%d s",self.count];
        [self.optionVarButton setTitle:str forState:UIControlStateNormal];
        self.count --;
    }
    
}


- (IBAction)scanPassword:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected == YES) {
        self.password.secureTextEntry = NO;
    }else
    {
        self.password.secureTextEntry = YES;
    }
    
}


//密码中不能包含特殊字符

-(BOOL)isIncludeSpecialCharact: (NSString *)str {
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}

- (BOOL)isValidateMobile:(NSString *)mobile{
    //手机号以13、15、18开头，八个\d数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
    
}

-(int)checkIsHaveNumAndLetter:(NSString*)password{
    //数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:password
                                                                       options:NSMatchingReportProgress
                                                                         range:NSMakeRange(0, password.length)];
    
    //英文字条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合英文字条件的有几个字节
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    
    if (tNumMatchCount == password.length) {
        //全部符合数字，表示沒有英文
        return 1;
    } else if (tLetterMatchCount == password.length) {
        //全部符合英文，表示沒有数字
        return 2;
    } else if (tNumMatchCount + tLetterMatchCount == password.length) {
        //符合英文和符合数字条件的相加等于密码长度
        return 3;
    } else {
        return 4;
        //可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误
    }
    
}




- (IBAction)userToRegisterAction:(id)sender {
 
    
    if(self.telephone.text.length == 0){
        [Public showJGHUDWhenError:self.view msg:@"手机号不能为空!"];
        return;
    }
    
    if(self.telephone.text.length < 11 || self.telephone.text.length > 11){
        [Public showJGHUDWhenError:self.view msg:@"手机号码输入不正确"];
        return;
    }
    
    if(self.varCode.text.length == 0){
        [Public showJGHUDWhenError:self.view msg:@"验证码不能为空!"];
        return;
    }
    
    if(self.varCode.text.length != 4){
        [Public showJGHUDWhenError:self.view msg:@"验证码输入不正确"];
        return;
    }
    
    if(self.password.text.length == 0){
        [Public showJGHUDWhenError:self.view msg:@"密码不能为空!"];
        return;
    }
    
    if (self.password.text.length < 6 || self.password.text.length > 18) {
        [Public showJGHUDWhenError:self.view msg:@"密码为6-18位的字母或数字"];
        return;
    }
    
    if ([self checkIsHaveNumAndLetter:self.password.text] == 4) {
        [Public showJGHUDWhenError:self.view msg:@"密码为6-18位的字母或数字，不能包含特殊字符"];
        return;
    }
    
 
    [[LYZNetWorkEngine sharedInstance] userRegisterPhone:self.telephone.text captcha:self.varCode.text password:self.password.text versioncode:VersionCode devicenum:DeviceNum fromtype:FromType block:^(int event, id object) {
        if (event == 1) {
            NSString * registMsg = [(UserRigisterResponse*)object msg];
            [Public showMessageWithHUD:self.view message:@"注册成功！"];
            [self.navigationController popViewControllerAnimated:YES];
            LYLog(@"注册 信息 ---->>>>%@",registMsg);
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

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [self.reach startNotifier];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
