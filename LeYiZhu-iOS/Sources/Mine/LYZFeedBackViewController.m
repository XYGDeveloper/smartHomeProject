//
//  LYZFeedBackViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZFeedBackViewController.h"
#import "LYZPhoneCall.h"
#import "PlaceHolderTextView.h"
#import "LoginManager.h"
#import "Public+JGHUD.h"

@interface LYZFeedBackViewController ()<UITextViewDelegate>

@property (nonatomic, strong) PlaceHolderTextView *textView;

@end

@implementation LYZFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"意见反馈";
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    [self configUI];
    
}

-(void)configUI{
    [self setRightNavBarBtn];
    [self createContentTextView];
}

-(void)setRightNavBarBtn{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.bounds = CGRectMake(0, 0, 60, 30);
    UIImage * image = [[UIImage imageNamed:@"icon_phone_left"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [rightButton setImage:image forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(phoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = - 20;
    self.navigationItem.rightBarButtonItems = @[spaceItem,rightItem];
}

-(void)createContentTextView{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    self.textView = [[PlaceHolderTextView alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, SCREEN_WIDTH, 200)];
    self.textView.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    self.textView.textColor = [UIColor blackColor];
    self.textView.scrollEnabled = NO;
    self.textView.placeholder = @"请输入您要的反馈内容";
    self.textView.placeholderColor = LYZTheme_warmGreyFontColor;
    [self.view addSubview:self.textView];
    [self.textView becomeFirstResponder];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(DefaultLeftSpace, self.textView.bottom + 20, (SCREEN_WIDTH - 2*DefaultLeftSpace), 40);
    submitBtn.backgroundColor = LYZTheme_paleBrown;
    submitBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 5.0f;
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Btn Actions

-(void)phoneBtnClick:(id)sender{
    [LYZPhoneCall noAlertCallPhoneStr:CustomerServiceNum withVC:self];
}

-(void)submitBtnClick:(UIButton *)sender{
    if (self.textView.text.length == 0) {
        [Public showJGHUDWhenError:self.view msg:@"请填写您的意见后再提交！"];
        return;
    }
    
    [[LYZNetWorkEngine sharedInstance] feedback:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:[LoginManager instance].appUserID content:_textView.text block:^(int event, id object) {
        if (event == 1) {
            [Public showJGHUDWhenSuccess:self.view msg:@"提交成功！"];
            [self performSelector:@selector(back) withObject:nil afterDelay:0.5];
        }else{
             [Public showJGHUDWhenSuccess:self.view msg:@"服务器出问题啦~！"];
        }
    }];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
