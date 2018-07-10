//
//  ResetViewController.m
//  LeYiZhu-iOS
//
//  Created by L on 2017/3/21.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "ResetViewController.h"
#import "Public+JGHUD.h"
#import "GCD.h"
#import "LoginManager.h"
#import <Reachability.h>
@interface ResetViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (nonatomic,assign)BOOL flag;

@end

@implementation ResetViewController


#pragma mark- Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
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

- (IBAction)sureAction:(id)sender {
    
    if(self.password.text.length == 0){
        [Public showJGHUDWhenError:self.view msg:@"密码不能为空!"];
        return;
    }
    
    if (self.password.text.length < 6 || self.password.text.length > 18) {
        
        [Public showJGHUDWhenError:self.view msg:@"密码为6-18位的字母或数字"];
        return;
    }
    
    
    if ([self isIncludeSpecialCharact:self.password.text]) {
        [Public showJGHUDWhenError:self.view msg:@"密码为6-18位的字母或数字，不能包含特殊字符"];
        return;
    }
    
   
    [[LYZNetWorkEngine sharedInstance] userResetPswWithPhone:self.telephone password:self.password.text captcha:self.varcode devicenum:DeviceNum fromtype:FromType block:^(int event, id object) {
        
        if (event == 1) {
            NSString * registMsg = [(UserRigisterResponse*)object msg];
            [Public showMessageWithHUD:self.view message:@"修改密码成功！"];
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
    
    self.password.delegate = self;
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    self.sureButton.layer.cornerRadius = 6;
    self.password.clearButtonMode = UITextFieldViewModeWhileEditing;
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [reach startNotifier];
    // Do any additional setup after loading the view from its nib.
}

- (void) reachabilityChanged: (NSNotification*)note {
    Reachability * reach = [note object];
    
    if(![reach isReachable])
    {
        // self.optionVarButton.enabled = NO;
        self.flag = YES;
    }
    
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
