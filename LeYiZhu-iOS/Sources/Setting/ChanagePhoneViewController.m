//
//  ChanagePhoneViewController.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/10.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "ChanagePhoneViewController.h"
#import "Public+JGHUD.h"
#import "LoginManager.h"
#import "User.h"
#import "ChangePhoneStep2ViewController.h"
@interface ChanagePhoneViewController ()
@property (nonatomic , weak) IBOutlet UITextField * pswTextField;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@end

@implementation ChanagePhoneViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"修改手机号";
    self.sureButton.layer.cornerRadius = 6;
    self.sureButton.backgroundColor = LYZTheme_paleBrown;
    [self resetUI];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    // Do any additional setup after loading the view from its nib.
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


-(IBAction)changePhoneNum:(id)sender{
    
    NSString *password = self.pswTextField.text;

    if(password.length == 0){
        [Public showJGHUDWhenError:self.view msg:@"密码不能为空!"];
        return;
    }
    
    if (password.length < 6 || password.length > 18) {
        
        [Public showJGHUDWhenError:self.view msg:@"密码为6-18位的字母或数字"];
        return;
    }
    
    if ([self checkIsHaveNumAndLetter:password] == 4) {
        
        [Public showJGHUDWhenError:self.view msg:@"密码为6-18位的字母或数字,不能包含特殊字符"];
        return;
    }
    
    JGProgressHUD *hud = [Public hudWhenRequest];
    [hud showInView:self.view animated:YES];
    
    User* userInfo = [LoginManager instance].userInfo;
    
    [[LYZNetWorkEngine sharedInstance] userLogin:userInfo.phone password:password versioncode:VersionCode devicenum:DeviceNum fromtype:FromType block:^(int event, id object) {
        
        [hud dismissAnimated:YES];
        
        if (event == 1) {
           
            JGProgressHUD *hud =  [Public hudWhenSuccessWithMsg:@"验证成功"];
            [hud showInView:self.view];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                ChangePhoneStep2ViewController * step2Vc = [[ChangePhoneStep2ViewController alloc] init];
                step2Vc.type = changeType;
                [self.navigationController pushViewController:step2Vc animated:YES];
                [hud dismissAnimated:YES];
            });
            
        }else{
            NSString *msg = [NSString  stringWithFormat:@"%@",object];
            [Public showJGHUDWhenError:self.view msg:msg];
            LYLog(@"ERROR IS ----->>>>>%@",object);
        }
    }];


}

-(void)resetUI{
    _pswTextField.text = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
