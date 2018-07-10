//
//  YaoQingController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2016/12/7.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "YaoQingController.h"
#import "UIImage+YYAdd.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>
#import "Public+JGHUD.h"
#import "UIViewController+BarButton.h"
#import "LYZPhoneCall.h"
#import "UIView+SetRect.h"
#import "GCD.h"



@interface YaoQingController ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation YaoQingController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.bounds = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    self.title = @"邀请好友";
    [self setRightNavbar];

//    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, SCREEN_HEIGHT -64)];
//    [self.view addSubview:web];
//
//    NSURL *url = [[NSURL alloc]initWithString:InviteFriend];
//    [web loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self setupUI];
    [self getCopywriting];
    
    
}

-(void)getCopywriting{
    [[LYZNetWorkEngine sharedInstance] getCopyWritingWithType:@1 block:^(int event, id object) {
        if (event == 1) {
            GetCopywritingResponse *response = (GetCopywritingResponse *)object;
           NSDictionary *dic = response.result;
            [GCDQueue executeInMainQueue:^{
                self.contentLabel.text = dic[@"copywriting"];
            }];
        }else{
            
        }
    }];
}

-(void)setupUI{
    UIButton *inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    inviteBtn.frame = CGRectMake(0, 0, 250, 134);
    inviteBtn.centerX = SCREEN_WIDTH /2.0;
    inviteBtn.y = 90;
    [inviteBtn setBackgroundImage:[UIImage imageNamed:@"envelope"] forState:UIControlStateNormal];
    inviteBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    inviteBtn.titleLabel.numberOfLines = 0;
    inviteBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [inviteBtn setTitle:[NSString stringWithFormat:@"您的邀请码\n%@",self.inviteCode] forState:UIControlStateNormal];
    [inviteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    inviteBtn.titleEdgeInsets = UIEdgeInsetsMake(10, 0, -10, 0);
    [self.view addSubview:inviteBtn];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
    title.textColor = LYZTheme_BrownishGreyFontColor;
    title.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    title.text = @"活动规则";
    [title sizeToFit];
    title.centerX = SCREEN_WIDTH /2.0;
    title.y = inviteBtn.bottom + 52;
    [self.view addSubview:title];
    
   self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, title.bottom + 15, SCREEN_WIDTH - 2*25, 40)];
    self.contentLabel.textColor = RGB(166, 166, 166);
    self.contentLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    self.contentLabel.numberOfLines = 0;

    [self.view addSubview:self.contentLabel];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(25, self.contentLabel.bottom + 60, SCREEN_WIDTH - 2* 25, 42);
    shareBtn.layer.cornerRadius = 5.0f;
    shareBtn.backgroundColor = LYZTheme_paleBrown;
    [shareBtn setTitle:@"立即分享" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:17];
    [shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    
}

-(void)setRightNavbar{
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    rightBtn.bounds = CGRectMake(0, 0, 60, 30);
//    UIImage * phoneImg = [[UIImage imageNamed:@"icon_partook"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [rightBtn setImage:phoneImg forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    spaceItem.width = - 20;
//    self.navigationItem.rightBarButtonItems = @[spaceItem,rightItem];
    
//      UIImage * phoneImg = [[UIImage imageNamed:@"icon_partook"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [self addRightBarButtonWithFirstImage:phoneImg action:@selector(share:)];
    
    UIImage * image = [[UIImage imageNamed:@"icon_phone_left"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addRightBarButtonWithFirstImage:image action:@selector(phoneBtnClick:)];
}


-(void)share:(id)sender{
    [self share];
}

-(void)share{
    NSArray *preplatform = @[@(UMSocialPlatformType_WechatSession) , @(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone) ,@(UMSocialPlatformType_TencentWb), @(UMSocialPlatformType_Sina),@(UMSocialPlatformType_DingDing),@(UMSocialPlatformType_Douban),@(UMSocialPlatformType_Renren),@( UMSocialPlatformType_YixinSession),@(UMSocialPlatformType_YixinTimeLine),@(UMSocialPlatformType_Linkedin),@(UMSocialPlatformType_Sms),@(UMSocialPlatformType_Email)
                             ];
    [UMSocialUIManager setPreDefinePlatforms:preplatform];
    UMSocialMessageObject *msg = [[UMSocialMessageObject alloc]init];
    msg.title = @"立即下载乐易住APP";
    msg.text = @"与您的好友共享优质入住体验！！！！";
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        LYLog(@"userInfo : %@" , userInfo);
        
        if(platformType == UMSocialPlatformType_WechatSession){
            
        }
        [self shareWebPageToPlatformType:platformType];
    }];
}

//网页分享
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    //    NSString* thumbURL =  @"https://www.baidu.com";
    NSString* thumbURL = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"立即下载乐易住APP" descr:@"与您的好友共享优质入住体验！！！" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = [NSString stringWithFormat:@"https://static.smartlyz.com/app/appvipshare/joinvip.html?invitecode=%@",self.inviteCode] ;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            [Public showJGHUDWhenError:self.view msg:@"分享失败！"];
        }else{
            [Public showJGHUDWhenSuccess:self.view msg:@"分享成功！"];
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //        [self alertWithError:error];
    }];
}

-(void)phoneBtnClick:(id)sender{
    [LYZPhoneCall noAlertCallPhoneStr:CustomerServiceNum withVC:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
