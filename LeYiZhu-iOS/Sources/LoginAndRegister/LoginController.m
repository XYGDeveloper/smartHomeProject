//
//  LoginController.m
//  LeYiZhu-iOS
//
//  Created by a a  on 2016/11/18.
//  Copyright © 2016年 lyz. All rights reserved.
#import "LoginController.h"
#import "AppDelegate.h"
#import "Public+JGHUD.h"
#import "LoginManager.h"
#import "WXApi.h"
#import "NSString+YYAdd.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboSDK.h"
#import "UIAlertView+Block.h"
#import "ThirdLoginInfoModel.h"
#import "ChangePhoneStep2ViewController.h"
#import "GCD.h"
#import "Masonry.h"
#import "RegisterViewController.h"
#import "ForgettonViewController.h"
#import "SegmentContainer.h"
#import <Reachability.h>
#import "GCD.h"
#import "User.h"
#import "MineInfoResponse.h"
#import "BaseMineInfoModel.h"

@interface LoginController ()<TencentLoginDelegate , TencentSessionDelegate,SegmentContainerDelegate>


@property (nonatomic , strong) TencentOAuth *tencentOAuth;

@property (nonatomic, strong) SegmentContainer *container;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong)UIView *topContentView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UILabel *middleLabel;
@property (nonatomic,strong) UIButton *rightButton;
//

@property (nonatomic, strong) UIView *leftline;
@property (nonatomic, strong) UILabel *thirdLabel;
@property (nonatomic,strong) UIView *rightline;
//
@property (nonatomic,strong)UIButton *wxButton;

@property (nonatomic,strong)UIButton *qqButton;
@property (nonatomic,strong)UIButton *weiboButton;
//以下是正常登录属性

@property (nonatomic,strong)UIView *nomalLoginContentView;
@property (nonatomic,strong)UITextField *telephone;
@property (nonatomic,strong)UITextField *password;
@property (nonatomic,strong)UIButton *normalLoginButton;
@property (nonatomic,strong)UIButton *phoneIcon;
@property (nonatomic,strong)UIButton *passwordIcon;
@property (nonatomic,strong)UIButton *findButton;

//以下是快捷方式登录
@property (nonatomic,strong)UIView *quiteLoginContentView;
@property (nonatomic,strong)UITextField *phone;
@property (nonatomic,strong)UITextField *varcode;
@property (nonatomic,strong)UIButton *quiteLoginButton;
@property (nonatomic,strong)UIButton *telephoneIcon;
@property (nonatomic,strong)UIButton *varcodeIcon;
@property (nonatomic,strong)UIButton *getOptionButton;
//

@property (nonatomic , strong) NSTimer *codeTimer;
@property (nonatomic , assign) int count ;
@property (nonatomic,assign)BOOL flag;
@property (nonatomic,strong)Reachability *reach;


@end


@implementation LoginController


- (NSArray *)titleArray
{
    
    if (!_titleArray) {
        
        _titleArray = [NSArray arrayWithObjects:@"手机快捷登录", nil];
    }
    return _titleArray;
}


#pragma mark - SegmentContainerDelegate
- (NSUInteger)numberOfItemsInSegmentContainer:(SegmentContainer *)segmentContainer {
    return self.titleArray.count;
}

- (NSString *)segmentContainer:(SegmentContainer *)segmentContainer titleForItemAtIndex:(NSUInteger)index {
    return [self.titleArray objectAtIndex:index];
}

- (id)segmentContainer:(SegmentContainer *)segmentContainer contentForIndex:(NSUInteger)index {
    
    
    
    
#pragma mark-----------隐藏登录，后续可能会有用-------------------------------------------------------------------------------------------
    /*
    if (index == 0) {
        
        self.nomalLoginContentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight- 60- 200)];
        
        self.phoneIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.phoneIcon setBackgroundImage:[UIImage imageNamed:@"Login_telephone_icon"] forState:UIControlStateNormal];
        [self.nomalLoginContentView addSubview:_phoneIcon];
        [self.phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(40);
            
        }];
        
        self.telephone = [[UITextField alloc]init];
        self.telephone.placeholder = @"请输入您的手机号";
        self.telephone.keyboardType = UIKeyboardTypeNumberPad;
        self.telephone.clearButtonMode = UITextFieldViewModeAlways;
        [self.nomalLoginContentView addSubview:_telephone];
        [self.telephone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.phoneIcon.mas_right).mas_equalTo(15);
            make.right.mas_equalTo(self.nomalLoginContentView.mas_right).mas_equalTo(-20);
            make.height.mas_equalTo(40);
            make.centerY.mas_equalTo(self.phoneIcon);
        }];
        
        UIView *lineview = [[UIView alloc]init];
        lineview.backgroundColor = kLineColor;
        [self.nomalLoginContentView addSubview:lineview];
        [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.phoneIcon.mas_left);
            make.right.mas_equalTo(self.telephone.mas_right);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(self.phoneIcon.mas_bottom).mas_equalTo(20);
        }];
        
        
        
        self.passwordIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.passwordIcon setBackgroundImage:[UIImage imageNamed:@"Login_varcode_icon"] forState:UIControlStateNormal];
        [self.nomalLoginContentView addSubview:_passwordIcon];
        [self.passwordIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(lineview.mas_bottom).mas_equalTo(20);
            
        }];
        
        self.password = [[UITextField alloc]init];
        self.password.placeholder = @"请输入您的密码";
        self.password.clearButtonMode = UITextFieldViewModeAlways;
        self.password.secureTextEntry = YES;
        [self.nomalLoginContentView addSubview:_password];
        [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.passwordIcon.mas_right).mas_equalTo(15);
            make.right.mas_equalTo(self.nomalLoginContentView.mas_right).mas_equalTo(-20);
            make.height.mas_equalTo(20);
            make.centerY.mas_equalTo(self.passwordIcon);
        }];

        UIView *lineview1 = [[UIView alloc]init];
        lineview1.backgroundColor = kLineColor;
        [self.nomalLoginContentView addSubview:lineview1];
        [lineview1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(self.passwordIcon.mas_bottom).mas_equalTo(20);
        }];
        
        self.normalLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.normalLoginButton setTitle:@"登录" forState:UIControlStateNormal];
        [self.normalLoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.normalLoginButton addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.nomalLoginContentView addSubview:_normalLoginButton];
        self.normalLoginButton.layer.cornerRadius = 6;
        self.normalLoginButton.backgroundColor = LYZTheme_paleBrown;
        self.normalLoginButton.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16.0f];
        [self.normalLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(lineview1.mas_bottom).mas_equalTo(50);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(56);
            
        }];
        
        self.findButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.findButton setTitle:@"登录遇到问题？" forState:UIControlStateNormal];
        [self.findButton setTitleColor:[UIColor colorWithRed:145/255.0f green:145/255.0f blue:145/255.0f alpha:1.0f] forState:UIControlStateNormal];
        self.findButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.findButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.nomalLoginContentView addSubview:_findButton];
        [self.findButton addTarget:self action:@selector(forgetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.findButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.normalLoginButton);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(25);
            make.top.mas_equalTo(self.normalLoginButton.mas_bottom).mas_equalTo(5);
        }];
        return _nomalLoginContentView;
        
    }
    
    
    else
    {
     
     
     */
    if (index == 0) {
        
        self.quiteLoginContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight- 60- 200)];
        self.telephoneIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.telephoneIcon setBackgroundImage:[UIImage imageNamed:@"Login_telephone_icon"] forState:UIControlStateNormal];
        [self.quiteLoginContentView addSubview:_telephoneIcon];
        [self.telephoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(40);
        }];
        self.phone = [[UITextField alloc] init];
        self.phone.placeholder = @"请输入您的手机号";
        self.phone.keyboardType = UIKeyboardTypeNumberPad;
        self.phone.clearButtonMode = UITextFieldViewModeAlways;
        [self.quiteLoginContentView addSubview:_phone];
        [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.telephoneIcon.mas_right).mas_equalTo(15);
            make.width.mas_equalTo(180);
            make.height.mas_equalTo(40);
            make.centerY.mas_equalTo(self.telephoneIcon);
        }];
        UIView *lineview01 = [[UIView alloc]init];
        lineview01.backgroundColor = kLineColor;
        [self.quiteLoginContentView addSubview:lineview01];
        [lineview01 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.phone.mas_right).mas_equalTo(0);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(38);
            make.centerY.mas_equalTo(self.phone);
        }];

        self.getOptionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.getOptionButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.getOptionButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [self.getOptionButton setTitleColor:LYZTheme_paleBrown forState:UIControlStateNormal];
        [self.getOptionButton addTarget:self action:@selector(getVarCodeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.quiteLoginContentView addSubview:_getOptionButton];
        [self.getOptionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lineview01.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(self.phone);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(40);
        }];

        UIView *lineview0 = [[UIView alloc]init];
        lineview0.backgroundColor = kLineColor;
        [self.quiteLoginContentView addSubview:lineview0];
        [lineview0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.telephoneIcon.mas_left);
            make.right.mas_equalTo(self.getOptionButton.mas_right);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(self.telephoneIcon.mas_bottom).mas_equalTo(20);
        }];
        
        self.varcodeIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.varcodeIcon setBackgroundImage:[UIImage imageNamed:@"Login_varcode_pic"] forState:UIControlStateNormal];
        [self.quiteLoginContentView addSubview:_varcodeIcon];
        [self.varcodeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(lineview0.mas_bottom).mas_equalTo(20);
            
        }];
        
        self.varcode = [[UITextField alloc]init];
        self.varcode.placeholder = @"请输入您的短信验证码";
        self.varcode.keyboardType = UIKeyboardTypeNumberPad;
        self.password.clearButtonMode = UITextFieldViewModeAlways;
        [self.quiteLoginContentView addSubview:_varcode];
        [self.varcode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.varcodeIcon.mas_right).mas_equalTo(15);
            make.right.mas_equalTo(self.quiteLoginContentView.mas_right).mas_equalTo(-40);
            make.height.mas_equalTo(40);
            make.centerY.mas_equalTo(self.varcodeIcon);
        }];
        
        UIView *lineview2 = [[UIView alloc]init];
        lineview2.backgroundColor = kLineColor;
        [self.quiteLoginContentView addSubview:lineview2];
        [lineview2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(self.varcode.mas_bottom).mas_equalTo(5);
        }];
        
        self.quiteLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.quiteLoginButton setTitle:@"注册/登录" forState:UIControlStateNormal];
        self.quiteLoginButton.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:18.0f];
        [self.quiteLoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.quiteLoginButton addTarget:self action:@selector(QuiteLoginByCache:) forControlEvents:UIControlEventTouchUpInside];
        [self.quiteLoginContentView addSubview:_quiteLoginButton];
        self.quiteLoginButton.layer.cornerRadius = 6;
        self.quiteLoginButton.backgroundColor = LYZTheme_paleBrown;
        [self.quiteLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(lineview2.mas_bottom).mas_equalTo(50);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(56);
        }];
        return _quiteLoginContentView;
  //  }
     
    }else
    {
    
        return nil;
        
    
    }
    
    
    
}


- (void)segmentContainer:(SegmentContainer *)segmentContainer didSelectedItemAtIndex:(NSUInteger)index {
    
    
}

- (void) reachabilityChanged: (NSNotification*)note {
    Reachability * reach = [note object];
    
    if(![reach isReachable])
    {
        // self.optionVarButton.enabled = NO;
        self.flag = YES;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTopView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册/登录";
    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    dele.loginVC = self;
//    [self initUI];
//    [self setupView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weiboDidLoginNotification:) name:@"weiboDidLoginNotification" object:nil];
    self.reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [self.reach startNotifier];
    
    
}

- (void)initTopView{

    self.topContentView = [[UIView alloc]init];
    self.topContentView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_topContentView];
    [self.topContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
        
    }];
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftButton setTitle:@"" forState:UIControlStateNormal];
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"pay_icon_close"] forState:UIControlStateNormal];
    [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.topContentView addSubview:_leftButton];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(30);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    self.middleLabel = [[UILabel alloc]init];
    self.middleLabel.text = @"注册/登录";
    self.middleLabel.textAlignment = NSTextAlignmentCenter;
    self.middleLabel.textColor = [UIColor whiteColor];
    [self.topContentView addSubview:_middleLabel];
    [self.middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.topContentView);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(20);

    }];
    
//    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.rightButton setTitle:@"注册" forState:UIControlStateNormal];
//    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
//    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.rightButton addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.topContentView addSubview:_rightButton];
//    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-10);
//        make.top.mas_equalTo(20);
//        make.width.mas_equalTo(40);
//        make.height.mas_equalTo(40);
//    }];
    
    self.container = [[SegmentContainer alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,kScreenHeight- 80- 200)];
    self.container.parentVC = self;
    self.container.delegate = self;
    self.container.titleFont = [UIFont systemFontOfSize:17.0f];
    self.container.titleNormalColor = [UIColor colorWithWhite:20 alpha:0.5];
    self.container.titleSelectedColor = [UIColor whiteColor];
    self.container.containerBackgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.container];
    //
    
    self.thirdLabel = [[UILabel alloc]init];
    self.thirdLabel.text = @"第三方登录";
    self.thirdLabel.textColor = [UIColor colorWithRed:145/255.0f green:145/255.0f blue:145/255.0f alpha:1.0f];
    self.thirdLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_thirdLabel];
    [self.thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.container.mas_bottom).mas_equalTo(40);
        make.centerX.mas_equalTo(self.view);
    }];
    
    self.leftline = [[UIView alloc]init];
    self.leftline.backgroundColor = kLineColor;
    [self.view addSubview:_leftline];
    [self.leftline mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(1);
        make.centerY.mas_equalTo(self.thirdLabel);
        make.right.mas_equalTo(self.thirdLabel.mas_left).mas_equalTo(-4);
    }];
    
    self.rightline = [[UIView alloc]init];
    self.rightline.backgroundColor = kLineColor;
    [self.view addSubview:_rightline];
    [self.rightline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(1);
        make.centerY.mas_equalTo(self.thirdLabel);
        make.left.mas_equalTo(self.thirdLabel.mas_right).mas_equalTo(4);
    }];
    
    //
    self.wxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.wxButton setTitle:@"" forState:UIControlStateNormal];
    [self.wxButton setBackgroundImage:[UIImage imageNamed:@"Login_wechat_icon"] forState:UIControlStateNormal];
    [self.wxButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.wxButton addTarget:self action:@selector(weichatBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_wxButton];
    [self.wxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.thirdLabel.mas_bottom).mas_equalTo(15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    UILabel *wxLabel = [[UILabel alloc]init];
    wxLabel.text = @"微信";
    wxLabel.textAlignment = NSTextAlignmentCenter;
    wxLabel.textColor = LYZTheme_paleBrown;
    wxLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:wxLabel];
    [wxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.wxButton.mas_bottom).mas_equalTo(0);
        make.centerX.mas_equalTo(self.view);
    }];
    
    if(![WXApi isWXAppInstalled]){
        wxLabel.hidden = YES;
        _wxButton.hidden = YES;
    }

    
    self.weiboButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.weiboButton setTitle:@"" forState:UIControlStateNormal];
    [self.weiboButton setBackgroundImage:[UIImage imageNamed:@"Login_weibo_icon"] forState:UIControlStateNormal];
    [self.weiboButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.weiboButton addTarget:self action:@selector(weiBoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_weiboButton];
    [self.weiboButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.wxButton.mas_left).mas_equalTo(-50);
        make.top.mas_equalTo(self.thirdLabel.mas_bottom).mas_equalTo(15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    UILabel *wbLabel = [[UILabel alloc]init];
    wbLabel.text = @"微博";
    wbLabel.textAlignment = NSTextAlignmentCenter;
    wbLabel.textColor = LYZTheme_paleBrown;
    [self.view addSubview:wbLabel];
    wbLabel.font = [UIFont systemFontOfSize:14.0f];

    [wbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.weiboButton.mas_bottom).mas_equalTo(0);
        make.centerX.mas_equalTo(self.weiboButton);
    }];
    
    if (![WeiboSDK isWeiboAppInstalled]) {
        wbLabel.hidden = YES;
        _weiboButton.hidden = YES;
    }
    
    self.qqButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.qqButton setTitle:@"" forState:UIControlStateNormal];
    [self.qqButton setBackgroundImage:[UIImage imageNamed:@"Login_telet_icon"] forState:UIControlStateNormal];
    [self.qqButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.qqButton addTarget:self action:@selector(qqBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_qqButton];
    [self.qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.wxButton.mas_right).mas_equalTo(50);
        make.top.mas_equalTo(self.thirdLabel.mas_bottom).mas_equalTo(15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    UILabel *qqLabel = [[UILabel alloc]init];
    qqLabel.text = @"QQ";
    qqLabel.font = [UIFont systemFontOfSize:14.0f];

    qqLabel.textAlignment = NSTextAlignmentCenter;
    qqLabel.textColor = LYZTheme_paleBrown;
    [self.view addSubview:qqLabel];
    [qqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.qqButton.mas_bottom).mas_equalTo(0);
        make.centerX.mas_equalTo(self.qqButton);
    }];
    if (![TencentOAuth iphoneQQInstalled]) {
        qqLabel.hidden = YES;
        _qqButton.hidden = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void)getVarCodeAction:(UIButton *)button
{

    if(self.phone.text.length == 0){
        [Public showJGHUDWhenError:self.view msg:@"手机账号不能为空!"];
        return;
    }
    
    if(self.phone.text.length < 11 || self.phone.text.length >11){
        [Public showJGHUDWhenError:self.view msg:@"手机号码输入不正确"];
        return;
    }
    
    if (![self.reach isReachable]) {
        [Public showMessageWithHUD:self.view message:@"当前网络没有连接，请检查网络"];
        return;
        
    }
    
    if (![self.reach isReachable]) {
        [Public showMessageWithHUD:self.view message:@"当前网络没有连接，请检查网络"];
        self.getOptionButton.enabled = NO;
        return;
    }
    
    if ([self.phone.text isEqualToString:@"15014047900"]) { //苹果审核专用
        return;
    }
    
    [self.varcode becomeFirstResponder];
    self.count = 60.0;
    self.getOptionButton.enabled = NO;
    self.codeTimer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(timerClick:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.codeTimer forMode:NSRunLoopCommonModes];
    [self.codeTimer fire];
    
    [[LYZNetWorkEngine sharedInstance] userGetCaptcha:self.phone.text versioncode:VersionCode devicenum:DeviceNum fromtype:FromType block:^(int event, id object) {
        
        if(event){
            NSLog(@"验证码：%@",self.varcode.text);
//            [Public showMessageWithHUD:self.view message:@"验证码发送成功"];
            [Public showJGHUDWhenSuccess:self.view msg:@"验证码发送成功"];
        }else{
             [Public showJGHUDWhenSuccess:self.view msg:@"验证码发送成功"];
//            [Public showMessageWithHUD:self.view message:@"验证码发送失败"];
        }
    }];
}


- (void)timerClick:(NSTimer *)timer{
    
    if(self.count == 0){
        NSString *str = @"获取验证码";
        [self.getOptionButton setTitle:str forState:UIControlStateNormal];
        
        [self.codeTimer invalidate];
        self.codeTimer = nil;
        
        self.getOptionButton.enabled = YES;
        self.count = 60;
    }else{
        NSString *str = [NSString stringWithFormat:@"%d s",self.count];
        [self.getOptionButton setTitle:str forState:UIControlStateNormal];
        self.count --;
    }
    
}

#pragma mark - 初始化UI

- (void)leftBtnClick:(UIButton*)sender
{
    
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }else
    {
    
        [self dismissViewControllerAnimated:YES completion:nil];
    
    }
  

}

#pragma mark - 按钮的响应
#pragma mark - 登录按钮

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



- (void)QuiteLoginByCache:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weiboDidLoginNotification:) name:@"weiboDidLoginNotification" object:nil];
    self.reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [self.reach startNotifier];
    
    if(self.phone.text.length == 0){
        
        [Public showJGHUDWhenError:self.view msg:@"手机号不能为空!"];
        return;
    }
    
    if(self.phone.text.length < 11 || self.phone.text.length > 11){
        [Public showJGHUDWhenError:self.view msg:@"手机号码输入不正确"];
        return;
    }
    
    if(self.varcode.text.length == 0){
        [Public showJGHUDWhenError:self.view msg:@"验证码不能为空!"];
        return;
    }
    
    if (self.varcode.text.length != 4) {
        
        [Public showJGHUDWhenError:self.view msg:@"验证码输入不正确"];
        return;
        
    }
    
    if (![self.reach isReachable]) {
        [Public showJGHUDWhenError:self.view msg:@"网络没有连接或断开"];
        return;
    }
    
    if (![self.reach isReachable]) {
        [Public showJGHUDWhenError:self.view msg:@"网络没有连接或断开"];
        return;
    }
    
    JGProgressHUD *hud = [Public hudWhenRequest];
    [hud showInView:self.view animated:YES];
    [[LoginManager instance] loginWithPhone:self.phone.text varcode:self.varcode.text block:^(int event, id object) {
        [hud dismissAnimated:YES];
//        UserLoginResponse *loginResponse = (UserLoginResponse*)object;
//        UserInfo *userInfo = loginResponse.userInfo;
//        LYLog(@"userinfo : %@" ,userInfo);
//        [[LoginManager instance] saveUserInfo:userInfo];
        
        if (event == 1) {
            [self loginSuccess];
        }else if(event == 8) {
        
            [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
                if(buttonIndex == 0){
                    [self loginSuccess];
                }
                if(buttonIndex == 1){
                    //合并
                    [self mergeVistorOrders];
                }
            } title:nil message:@"您是否要合并游客订单？" cancelButtonName:@"取消" otherButtonTitles:@"合并", nil];
        }else{
            NSString *msg = [NSString  stringWithFormat:@"手机登录%@",object];
            [Public showJGHUDWhenError:self.view msg:msg];
        }
    }];
    

}

- (void)mergeVistorOrders
{
    LYLog(@"mergeVistorOrders");
    User *userInfo  = [LoginManager instance].userInfo;
    NSString *appUserID =  [LoginManager instance].appUserID;
    NSString *phone = userInfo.phone;
    [[LYZNetWorkEngine sharedInstance]mergeVisitorOrders:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID phone:phone block:^(int event, id object) {
        if(event == 1){
            [self loginSuccess];
        }else{
            NSString *msg = [NSString  stringWithFormat:@"%@",object];
            [Public showJGHUDWhenError:self.view msg:msg];

        }
    }];
}

#pragma mark - 注册按钮
- (void)registerBtnClick:(UIButton *)sender
{
    LYLog(@"registerBtnClick");
    
    
    RegisterViewController *regvc = [[RegisterViewController alloc]init];
    regvc.title = @"注册";
    [self.navigationController pushViewController:regvc animated:YES];
}
#pragma mark - 忘记按钮
- (void)forgetBtnClick:(UIButton *)sender
{
    LYLog(@"forgetBtnClick");
    ForgettonViewController *fvc = [[ForgettonViewController alloc]init];
    fvc.title = @"忘记密码";
    [self.navigationController pushViewController:fvc animated:YES];

}


- (void)weiboDidLoginNotification:(NSNotification*)notification
{
    LYLog(@"%s",__func__);
    
    NSDictionary *userInfo = [notification userInfo];
    NSString *accessToken = [userInfo objectForKey:@"accessToken"];
    NSString *uid = [userInfo objectForKey:@"userId"];
    
    LYLog(@"userInfo %@",userInfo);
    
    [self getWeiboUserInfoWithAccessToken:accessToken uid:uid];
}

- (void)getWeiboUserInfoWithAccessToken:(NSString *)accessToken uid:(NSString *)uid
{
    NSString *url =[NSString stringWithFormat:
                    @"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",accessToken,uid];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl
                                                     encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data)
            {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:NSJSONReadingMutableContainers error:nil];
                LYLog(@"%@",dic);
                NSString *openId = [dic objectForKey:@"id"];
                NSString *memNickName = [dic objectForKey:@"name"];
                NSString *memSex = [[dic objectForKey:@"gender"] isEqualToString:@"m"] ? @"1" : @"0";
                NSString *avatar_large = [dic objectForKey:@"avatar_large"];
                [self thirdLogin:openId nickname:memNickName headimgurl:avatar_large type:weiBoType];
//                [self loginWithOpenId:openId memNickName:memNickName memSex:memSex];
            }
        });
        
    });
}


- (void)weiBoBtnClick:(UIButton *)sender
{
    LYLog(@"%s",__func__);
    
    
    
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = @"https://api.weibo.com/oauth2/default.html";
    request.scope = @"all";
//    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
//                         @"Other_Info_1": [NSNumber numberWithInt:123],
//                         @"Other_Info_2": @[@"obj1", @"obj2"],
//                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
    
    
   
    
}

- (void)weichatBtnClick:(UIButton *)sender
{
    LYLog(@"weichatBtnClick");
    SendAuthReq *authReq = [[SendAuthReq alloc] init];
    authReq.scope = @"snsapi_userinfo";
    authReq.state = @"123";
    [WXApi sendReq:authReq];

    
//    if([WXApi isWXAppInstalled]){
//        
//        
//        
//    }else{
//        [Public showJGHUDWhenError:self.view msg:@"手机上没有安装微信！"];
//        return;
//    }
    
}

#pragma mark - QQ登录代理

- (void)getUserInfoResponse:(APIResponse *)response
{
    LYLog(@"getUserInfoResponse : %@" , response);
    
    NSDictionary *userInfo = [response jsonResponse];
    
    LYLog(@"userInfo : %@" , userInfo);
    
    NSString *openID = self.tencentOAuth.openId;
    NSString *nickname = userInfo[@"nickname"];
    NSString *figureurl_qq_2 = userInfo[@"figureurl_qq_2"];
//
    [self thirdLogin:openID nickname:nickname headimgurl:figureurl_qq_2 type:QQType];
}


- (void)tencentDidLogin
{
    LYLog(@"Appdelegate tencentDidLogin");
    if (_tencentOAuth.accessToken.length > 0) {
        // 获取用户信息
        [_tencentOAuth getUserInfo];
        
        
    } else {
        LYLog(@"登录不成功 没有获取accesstoken");
    }
}

//非网络错误导致登录失败：
- (void)tencentDidNotLogin:(BOOL)cancelled {
    if (cancelled) {
        LYLog(@"用户取消登录");
    } else {
        LYLog(@"登录失败");
    }
}

- (void)tencentDidNotNetWork
{
    LYLog(@"Appdelegate tencentDidNotNetWork");
    
}

- (TencentOAuth*)getTencentOAuth
{
    LYLog(@"getTencentOAuth");
    
    NSString *appid = @"1105837388";
    NSString *appScrent = @"MtxakfnTgHM6dSla";
    TencentOAuth *tencentOAuth = [[TencentOAuth alloc]initWithAppId:appid andDelegate:self];
    LYLog(@"tencentOAuth : %@" , tencentOAuth);
    return tencentOAuth;
}

- (void)qqBtnClick:(UIButton *)sender
{
    LYLog(@"qqBtnClick");
    
    TencentOAuth *tencentOAuth = [self getTencentOAuth];
    self.tencentOAuth = tencentOAuth;
//    , @"get_simple_userinfo", @"add_t"
    NSArray *permissions= [NSArray arrayWithObjects:@"get_user_info",@"get_simple_userinfo", @"add_t", nil];
    [tencentOAuth authorize:permissions];

}

- (void)thirdLogin:(NSString*)code nickname:(NSString*)nickname headimgurl:(NSString*)headimgurl type:(loginType)type
{
    NSString *name = nickname;
    if(name.length == 0){
        name = @" ";
    }
    NSString *img = headimgurl;
    if(img.length == 0){
        img = @" ";
    }
    
    [[LYZNetWorkEngine sharedInstance] thirdPartLoginWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType thirdID:code type:[NSString stringWithFormat:@"%li",type] nickName:name facePath:img block:^(int event, id object) {
        if(event == 1){
            LYLog(@"thirdLogin success !");
            ThirdLoginResponse *loginResponse = (ThirdLoginResponse*)object;
            UserInfo *userInfo = loginResponse.userInfo;
            LYLog(@"userinfo : %@" ,userInfo);
            [[LoginManager instance] saveUserInfo:userInfo];
          
            [self loginSuccess];
            
        }else if(event == 8) {
            
            NSLog(@"%@",object);
            
            [GCDQueue executeInMainQueue:^{
                [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
                    if(buttonIndex == 0){
                        [self loginSuccess];
                    }
                    if(buttonIndex == 1){
                        //合并
                        [self mergeVistorOrders];
                    }
                } title:nil message:@"您是否要合并游客订单？" cancelButtonName:@"取消" otherButtonTitles:@"合并", nil];
            }];
           
        }else if(event == 9){
            //提示用户绑定手机号码
            ThirdLoginInfoModel * model = [[ThirdLoginInfoModel alloc] init];
            model.thirdID = code;
            model.type = [NSString stringWithFormat:@"%li",type];
            model.nickName = name;
            model.facePath = img;
            
            [GCDQueue executeInMainQueue:^{
                ChangePhoneStep2ViewController *vc = [[ChangePhoneStep2ViewController alloc] init];
                vc.infoModel = model;
                vc.type = bindType;
                [self.navigationController pushViewController:vc animated:YES];
            }];
            
            
        }
        else{
            LYLog(@"thirdLogin failure !");
        }
    }];
}

#pragma mark - 3种登录方式的代理
- (void)weichatLogin:(SendAuthResp *)authResp
{
    
//    [self thirdLogin:authResp.code];
    
    NSString *appid = @"wx6885ece91f0b3ea7";
    NSString *code = authResp.code;
    NSString *secret = @"9962c7557069cd847b0f15a3fb80727c";
    
    NSString *weixinUrl = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",appid, secret , code];
    NSURL *url = [NSURL URLWithString:weixinUrl];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url  completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSString *resultStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            LYLog(@"resultStr : %@" , resultStr);
            NSDictionary *resultDict = [resultStr jsonValueDecoded];
            LYLog(@"resultDict : %@" , resultDict);
            
            NSString *refresh_token = resultDict[@"refresh_token"];
            NSString *access_token = resultDict[@"access_token"];
            NSString *unionid = resultDict[@"unionid"];
//            NSString *openid = 
            if(refresh_token.length > 0){
                [self weichatRequestUnionID:unionid refresh_token:access_token];
            }else{
                [GCDQueue executeInMainQueue:^{
                    [Public showJGHUDWhenError:self.view msg:@"登录失败！"];
                }];
                

            }
            LYLog(@"weichatLogin success!");
        }else{
            LYLog(@"weichatLogin failure!");
            [GCDQueue executeInMainQueue:^{
                [Public showJGHUDWhenError:self.view msg:@"登录失败！"];
            }];
        }
    }];
    [dataTask resume];
    
}

- (void)weichatRequestUnionID:(NSString*)openID refresh_token:(NSString*)token
{
//    https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
    NSString *userUrlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",token , openID];
    // 请求用户数据
    NSURL *url = [NSURL URLWithString:userUrlStr];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url  completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSString *resultStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *resultDict = [resultStr jsonValueDecoded];
            LYLog(@"weichatRequestUnionID resultDict : %@" , resultDict);
            
            NSString *openid = resultDict[@"openid"];
            NSString *headimgurl = resultDict[@"headimgurl"];
            NSString *nickname = resultDict[@"nickname"];

            if(openid.length > 0){
                [self thirdLogin:openID nickname:nickname headimgurl:headimgurl type:weChatType];
            }else{
                [GCDQueue executeInMainQueue:^{
                    [Public showJGHUDWhenError:self.view msg:@"登录失败！"];
                }];
            }
            LYLog(@"weichatRequestUnionID weichatRequestUnionID success!");
        }else{
            LYLog(@"weichatRequestUnionID weichatRequestUnionID failure!");
            [GCDQueue executeInMainQueue:^{
                [Public showJGHUDWhenError:self.view msg:@"登录失败！"];
            }];
        }
    }];
    [dataTask resume];
    
}

//登录成功的调用方法
- (void)loginSuccess
{
    WEAKSELF;
    if(self.presentBlock){
        [self dismissViewControllerAnimated:YES completion:^{
            weakSelf.presentBlock();
           [[LYZNetWorkEngine sharedInstance] getMineInfoBlock:^(int event, id object) {
               if (event == 1) {
                   MineInfoResponse *response = (MineInfoResponse *)object;
                   if ([response.baseMineInfo.isvip isEqualToString:@"N"]) {
                       [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationJoinVip object:nil];
                   }
               }else{
                    LYLog(@"Request Login");
               }
           }];
        }];
    }else{
        
        JGProgressHUD *hud =  [Public hudWhenSuccess];
        [hud showInView:[UIApplication sharedApplication].keyWindow];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            [delegate changeToMainVC];
            [hud dismissAfterDelay:0.0f animated:YES];

        });
    }
}

#pragma mark - 网络请求
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    LYLog(@" %@  dealloc",NSStringFromClass([self class]));
   [[NSNotificationCenter defaultCenter] removeObserver:self name:@"weiboDidLoginNotification" object:nil];
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
