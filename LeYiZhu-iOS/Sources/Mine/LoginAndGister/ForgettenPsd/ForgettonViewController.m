//
//  ForgettonViewController.m
//  denglu
//
//  Created by xyg on 2017/3/21.
//  Copyright © 2017年 xyg. All rights reserved.
//

#import "ForgettonViewController.h"
#import "Public+JGHUD.h"
#import "GCD.h"
#import "LoginManager.h"
#import "ResetViewController.h"
#import <Reachability.h>
@interface ForgettonViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *telephone;
@property (weak, nonatomic) IBOutlet UIButton *varcodeButton;
@property (weak, nonatomic) IBOutlet UITextField *varcode;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (nonatomic,strong)Reachability *reach;
@property (nonatomic , strong) NSTimer *codeTimer;
@property (nonatomic,assign)BOOL flag;
@property (nonatomic , assign) int count;

@end

@implementation ForgettonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    self.telephone.delegate = self;
    self.telephone.keyboardType = UIKeyboardTypeNumberPad;
    self.varcode.delegate = self;
    self.varcode.keyboardType = UIKeyboardTypeNumberPad;
    self.sureButton.layer.cornerRadius = 6;
    self.telephone.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.varcode.clearButtonMode = UITextFieldViewModeWhileEditing;
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

#pragma mark- Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    return YES;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}


- (IBAction)getVarcode:(id)sender {
    
    
    if(self.telephone.text.length == 0){
        [Public showJGHUDWhenError:self.view msg:@"手机账号不能为空!"];
        return;
    }
    if (![IICommons valiMobile:self.telephone.text]) {
        [Public showJGHUDWhenError:self.view msg:@"请输入正确的手机号码"];
        return;
    }
    
    
    
    if (![self.reach isReachable]) {
        [Public showMessageWithHUD:self.view message:@"当前网络没有连接，请检查网络"];
        return;
    }
    if (self.flag == YES) {
        
        self.varcodeButton.enabled = NO;
        [Public showMessageWithHUD:self.view message:@"当前网络没有连接，请检查网络"];
        return;
        
    }
    self.count = 60.0;
    self.varcodeButton.enabled = NO;
    self.codeTimer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(timerClick:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.codeTimer forMode:NSRunLoopCommonModes];
    [self.codeTimer fire];
    
    [[LYZNetWorkEngine sharedInstance] userGetCaptcha:self.telephone.text versioncode:VersionCode devicenum:DeviceNum fromtype:FromType block:^(int event, id object) {
        
        if(event){
            
            [Public showMessageWithHUD:self.view message:@"验证码发送成功！"];
            
        }else{
            
            if ([object isKindOfClass:[NSString class]]) {
                NSString *msg = [NSString  stringWithFormat:@"%@",object];
                [Public showJGHUDWhenError:self.view msg:msg];
                [Public showMessageWithHUD:self.view message:msg];
            }
        }
    }];
    
    
}

- (void)timerClick:(NSTimer *)timer
{
    if(self.count == 0){
        NSString *str = @"获取验证码";
        [self.varcodeButton setTitle:str forState:UIControlStateNormal];
        
        [self.codeTimer invalidate];
        self.codeTimer = nil;
        
        self.varcodeButton.enabled = YES;
        self.count = 60;
    }else{
        NSString *str = [NSString stringWithFormat:@"%d s",self.count];
        [self.varcodeButton setTitle:str forState:UIControlStateNormal];
        self.count --;
    }
    
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

- (IBAction)sureAction:(id)sender {
    
    if(self.telephone.text.length == 0){
        [Public showJGHUDWhenError:self.view msg:@"手机号不能为空!"];
        return;
    }
    
    if(self.telephone.text.length < 11 || self.telephone.text.length > 11){
        [Public showJGHUDWhenError:self.view msg:@"手机号码输入不正确"];
        return;
    }
    
    if(self.varcode.text.length == 0){
        [Public showJGHUDWhenError:self.view msg:@"验证码不能为空!"];
        return;
    }

    if(self.varcode.text.length != 4){
        [Public showJGHUDWhenError:self.view msg:@"验证码输入不正确"];
        return;
    }
  
 
    ResetViewController *reset = [ResetViewController new];
    reset.title = @"重设密码";
    reset.telephone = self.telephone.text;
    reset.varcode = self.varcode.text;
    reset.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:reset animated:YES];
    
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
