//
//  AppDelegate.m
//  LeYiZhu-iOS
//
//  Created by a a  on 2016/11/18.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginController.h"
#import "LoginManager.h"
#import "IQKeyboardManager.h"
#import "UIColor+HEX.h"
#import <AlipaySDK/AlipaySDK.h>
#import <WXApi.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboSDK.h"
#import <UMSocialCore/UMSocialCore.h>
#import "Public.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "LYZGuidViewController.h"
#import "CALayer+Transition.h"   // 过渡页动画需要
#import <Reachability.h>
#import "BaseTabBarController.h"
#import <Bugly/Bugly.h>
#import "LYZVersionManager.h"
#import "LYZUpdateView.h"
#import "AppDelegate+JPush.h"
// wifi test
#import "WiFiManager.h"
#import "LYZImaageUploaderManager.h"
#import "GCD.h"
#import "LYZAdView.h"
#import "ApplyVipViewController.h"
#import "Utils.h"
#import "UIDevice+Common.h"
//test
#import "IndicatorView.h"
#import "Calendar.h"
#import <objc/runtime.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#define BMAPKEY @"bguoN3QCQjHBgoboONY3QjrfjzMe9voz"
#define UMKey @"5854d8da8f4a9d5554000c09"
#define LYZAppID @"1190177668"
#import "XFAlertView.h"
#import <Reachability/Reachability.h>

BMKMapManager* _mapManager;
@interface AppDelegate ()<WXApiDelegate ,WeiboSDKDelegate,BMKGeneralDelegate,TencentSessionDelegate,selectDelegate,BMKGeneralDelegate,BaseMessageViewDelegate>
@property(strong,nonatomic)BMKMapManager *bmkMapManager;
@property (nonatomic, copy) NSString *appDownloadLink;
@property (nonatomic,assign) BOOL isVXPaySuceess;
@end

@implementation AppDelegate

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
    LYLog(@"didReceiveWeiboRequest");
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    
    LYLog(@"didReceiveWeiboResponse");
    
    if ([response isKindOfClass:WBAuthorizeResponse.class]){
        
        NSString *userId = [(WBAuthorizeResponse *)response userID];
        NSString *accessToken = [(WBAuthorizeResponse *)response accessToken];
        
        LYLog(@"userId %@",userId);
        LYLog(@"accessToken %@",accessToken);
        if (userId && accessToken) {
            NSDictionary *notification = @{
                                           @"userId" : userId,
                                           @"accessToken" : accessToken
                                           };

            [[NSNotificationCenter defaultCenter] postNotificationName:@"weiboDidLoginNotification"
                                                                object:self userInfo:notification];
        }
    }
    
}

#pragma mark -- QQ登录代理
- (void)getUserInfoResponse:(APIResponse *)response{
    
    LYLog(@"getUserInfoResponse : %@" , response);
}

- (void)tencentDidLogin{
    
    LYLog(@"Appdelegate tencentDidLogin");
}

- (void)tencentDidNotLogin:(BOOL)cancelled{
    
    LYLog(@"Appdelegate tencentDidNotLogin");
}

- (void)tencentDidNotNetWork{
    
    LYLog(@"Appdelegate tencentDidNotNetWork");
}

#pragma  AppDelegate
- (void)changeToMainVC
{
    [Utils updateCachedAppVersion];

    BaseTabBarController *vc = [[BaseTabBarController alloc] init];
    self.rootTab = vc;
    self.window.rootViewController = vc;
    
}

/** 创建引导页 */
- (void)createGuideVC {
    
    [self checkUpdate];
    
    if ([Utils shouldShowGuidePage]) {
        self.window.rootViewController = [HYNewFeatureCtr newFeatureVCWithImageNames:@[@"ggps_1_bg",@"ggps_2_bg",@"ggps_3_bg",@"ggps_4_bg",@"ggps_5_bg"]  dotImage:@"point_normal" currentDotImage:@"point_select" enterBlock:^{
            [self changeToMainVC];
        } configuration:^(UIButton *enterButton) { // 配置进入按钮
            enterButton.bounds = CGRectMake(0, 0, 120, 30);
            enterButton.layer.borderWidth = 1;
            enterButton.layer.cornerRadius  =15;
            enterButton.layer.borderColor = [UIColor whiteColor].CGColor;
            enterButton.center = CGPointMake(kScreenWidth * 0.5f, kScreenHeight* 0.93f);
            [enterButton setBackgroundColor:[UIColor clearColor]];
            [enterButton setTitle:@"立即体验" forState:UIControlStateNormal];
            [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            enterButton.titleLabel.font = [UIFont systemFontOfSize:18];
            
        }];
    } else {
        [self changeToMainVC];

    }
//    // 是否展示新特性界面
//    BOOL canShow = [HYNewFeatureCtr canShowNewFeature];
//    NSLog(@"----------是否要展示--------------%d",canShow);
//    if(canShow){ // 初始化新特性界面
//
//
//    }else{  // 主界面
//
//
//    }
 
}

#pragma mark -- 启动进入
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    // 状态栏颜色变白
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
#ifdef OpenIndicator
    self.indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200)/2.0, 0, 200, 50)];
    self.indicatorLabel.backgroundColor = [UIColor redColor];
    self.indicatorLabel.textColor = [UIColor blackColor];
    self.indicatorLabel.textAlignment = NSTextAlignmentCenter;
    self.indicatorLabel.text =  @"Show Voices Frequency";
    [self.window insertSubview:self.indicatorLabel atIndex:123];
    
    UIButton *indicatorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    indicatorBtn.frame = CGRectMake(SCREEN_WIDTH - 100, SCREEN_HEIGHT - 300, 100, 100);
    [indicatorBtn setBackgroundColor:[UIColor whiteColor]];
    [indicatorBtn setTitle:@"打开log" forState:UIControlStateNormal];
    [indicatorBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [indicatorBtn addTarget:self action:@selector(OpenLog) forControlEvents:UIControlEventTouchUpInside];
    [self.window  insertSubview:indicatorBtn atIndex:124];
    
    self.indicatorView = [[IndicatorView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
#endif
    
    [self initweixin];
    [self initWeiBoSDK];
    [self initKeyBoardManager];
    [self initUMengShare];
    [self setupJpush:launchOptions];
    self.bmkMapManager=[[BMKMapManager alloc] init];
    [self.bmkMapManager start:BMAPKEY generalDelegate:self];
//    [self initGrowingIO];
    [self initUMAnalytics];
//    [Bugly startWithAppId:@"900045770"];
    BuglyConfig * config = [[BuglyConfig alloc] init];
    // 设置自定义日志上报的级别，默认不上报自定义日志
    config.reportLogLevel = BuglyLogLevelWarn;
    [Bugly startWithAppId:@"900045770" config:config];
    config.debugMode = YES;
    [self detectUserStay];
    [self setDefaultSettings];
    [self createGuideVC];
    [AppDelegate progressWKContentViewCrash];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popAd:) name:kNotificationJoinVip object:nil];
    [self NetWorkMonitor];

//    [self getWiFiList];//wifi 测试
//
//    [self imgUpload];//图片上传测试

    return YES;
}

- (void)NetWorkMonitor{
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
    reach.unreachableBlock = ^(Reachability * reachability){
        [GCDQueue executeInMainQueue:^{
            [Public showMessageWithHUD:[UIApplication sharedApplication].keyWindow message:@"当前网络没有连接，请检查网络"];
        }];
    };
    [reach startNotifier];
}
//-(void)initGrowingIO{
//    [Growing startWithAccountId:@"be366d97ac821eb9"];
//    // 其他配置
//    // 开启Growing调试日志 可以开启日志
//     [Growing setEnableLog:NO];
//}

//test

-(void)OpenLog{
//    [self.window insertSubview:self.indicatorView atIndex:999];
     [Calendar showManualHiddenMessageViewInKeyWindowWithMessageObject:nil delegate:self viewTag:111];
}

//UM统计
-(void)initUMAnalytics{
    [MobClick setLogEnabled:YES];
    UMConfigInstance.appKey = UMKey;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    [MobClick setCrashReportEnabled:NO];   // 关闭Crash收集
}

//-(void)imgUpload{
//    UIImage *img = [UIImage imageNamed:@"Feature_1"];
//    [LYZImaageUploaderManager uploadImgs:@[img] withResult:^(NSArray *imgs) {
//        LYLog(@"imgs is ----> %@",imgs);
//    }];
//}
-(void)getWiFiList{
    [[WiFiManager instance] scanWifiInfos];
}

-(void) checkUpdate{
    //先网路请求是否升级版本
    LYZVersionManager * tool = [LYZVersionManager instance];
    [tool checkUpdateByLocateServer:^(BOOL allowUpdate, NSString *isforce) {
        NSLog(@"\\\\\\\\\\========%d,%@",allowUpdate,isforce);
        
        if (allowUpdate == YES) {
            [tool checkUpdateWithAppID:LYZAppID success:^(NSDictionary *resultDic, BOOL isNewVersion, NSString *newVersion) {
                if (isNewVersion== NO) {
                    return ;
                }else{
                    self.appDownloadLink = [[[resultDic objectForKey:@"results"] objectAtIndex:0] valueForKey:@"trackViewUrl"];
                    NSString *title                          = @"版本升级说明";
                    NSString *content                     = [[[resultDic objectForKey:@"results"] objectAtIndex:0] valueForKey:@"releaseNotes"];
                    NSString  *buttonTitle                =  @"立即升级";
                    BOOL isforceUpdate;
                    if ([isforce isEqualToString:@"Y"]) {
                        isforceUpdate = YES;
                        [GCDQueue executeInMainQueue:^{
                            UpdateViewMessageObject *messageObject = MakeUpdateViewObject(title,content, buttonTitle,isforceUpdate);
                            [LYZUpdateView showManualHiddenMessageViewInKeyWindowWithMessageObject:messageObject delegate:self viewTag:99];
                        }];
                    }else{
                        isforceUpdate = NO;
                        [GCDQueue executeInMainQueue:^{
                            UpdateViewMessageObject *messageObject = MakeUpdateViewObject(title,content, buttonTitle,isforceUpdate);
                            [LYZUpdateView showManualHiddenMessageViewInKeyWindowWithMessageObject:messageObject delegate:self viewTag:99];
                        }];
                    }
                }
            } failure:^(NSError *error) {
                
            }];
        }
    }];
}

-(void)detectUserStay{
    //用户有没有入住信息：有入住信息tabbar 显示入住页面
    [[LYZNetWorkEngine sharedInstance] detectUserStayblock:^(int event, id object) {
        if (event == 1) {
            DetectUserStayResponse *response = (DetectUserStayResponse *)object;
            NSDictionary *result = response.result;
            if ([result[@"isdetectstay"] isEqualToString:@"Y"]) {
                  [self.rootTab setSelectedIndex:1];
            }
        }
    }];
}

-(void)setDefaultSettings{
    if (![IICommons getPersistenceDataWithKey:kAutoOpenDoorKey]) {
          [IICommons setPersistenceData:@"Y" withKey:kAutoOpenDoorKey];
    }
}

-(void)popAd:(NSNotification *)noti{
    NSString *imgUrl                     = nil;
    NSString *imgName = @"update_vip_bg";
    NSString  *h5Url                =  GuidLink;
    actionType type               =  vipType;
    [GCDQueue executeInMainQueue:^{
        AdViewMessageObject *messageObject = MakeAdViewObject(imgUrl, imgName,h5Url, type, YES);
        [LYZAdView showManualHiddenMessageViewInKeyWindowWithMessageObject:messageObject delegate:self viewTag:1001];
    }];
    
    
}

#pragma mark - BaseMessageViewDelegate

- (void)baseMessageView:(__kindof BaseMessageView *)messageView event:(id)event {
    
    NSLog(@"%@, tag:%ld event:%@", NSStringFromClass([messageView class]), (long)messageView.tag, event);
   
    if (messageView.tag == 99) {
        NSURL *url = [NSURL URLWithString:self.appDownloadLink];
        [[UIApplication sharedApplication] openURL:url];
    }else if (messageView.tag == 1001){
         [messageView hide];
        AdViewMessageObject *object = (AdViewMessageObject *)event;
        if (object.type == vipType) {
            if (object.canClick) {
               
                BaseTabBarController *tab =(BaseTabBarController*) self.rootTab;
                ApplyVipViewController *vc = [[ApplyVipViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [tab.selectedViewController pushViewController:vc  animated:YES];

            }
        }
    }
}

- (void)baseMessageViewWillAppear:(__kindof BaseMessageView *)messageView {
    
    NSLog(@"%@, tag:%ld WillAppear", NSStringFromClass([messageView class]), (long)messageView.tag);
}

- (void)baseMessageViewDidAppear:(__kindof BaseMessageView *)messageView {
    
    NSLog(@"%@, tag:%ld DidAppear, contentView is %@", NSStringFromClass([messageView class]), (long)messageView.tag, NSStringFromClass([messageView.contentView class]));
}

- (void)baseMessageViewWillDisappear:(__kindof BaseMessageView *)messageView {
    
    NSLog(@"%@, tag:%ld WillDisappear", NSStringFromClass([messageView class]), (long)messageView.tag);
}

- (void)baseMessageViewDidDisappear:(__kindof BaseMessageView *)messageView {
    
    NSLog(@"%@, tag:%ld DidDisappear", NSStringFromClass([messageView class]), (long)messageView.tag);
}


- (void)click
{
    [self changeToMainVC];
    [self.window.layer transitionWithAnimType:TransitionAnimTypeReveal subType:TransitionSubtypesFromRight curve:TransitionCurveEaseIn duration:0.5f];
}


-(void)initBaiMap{
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"bguoN3QCQjHBgoboONY3QjrfjzMe9voz" generalDelegate:self];
    if (!ret) {
        LYLog(@"manager start failed!");
    }
    
}


- (void)initUMengShare
{
    
    LYLog(@"initUMengShare");
    
    NSString *weixinappid = @"wx6885ece91f0b3ea7";
    NSString *weixinsecret = @"9962c7557069cd847b0f15a3fb80727c";
    
    
    NSString *qqappid = @"1105837388";
    NSString *qqappScrent = @"MtxakfnTgHM6dSla";
    
    NSString *weiboappid = @"3315867836";
    NSString *weiboappScrent = @"9f18a108234bfd8bb82b1134d920994e";
    NSString *dingdingAppID = @"dingoag5r80qsbmtcl48xb";
    NSString *dingdingSecretKey = @"GOQ1W9XN5wFEArbfPQ8hkxOOTaVDrd8YXdzuWs18ABwBG9pGjVduB_O0D4ynuDQS";
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMKey];
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:weixinappid appSecret:weixinsecret redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatFavorite appKey:weixinappid appSecret:weixinsecret redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:weixinappid appSecret:weixinsecret redirectURL:@"http://mobile.umeng.com/social"];
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:qqappid  appSecret:qqappScrent redirectURL:@"http://mobile.umeng.com/social"];
    //新浪微博
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:weiboappid  appSecret:weiboappScrent redirectURL:@"http://mobile.umeng.com/social"];
    /* 钉钉的appKey */
    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DingDing appKey:dingdingAppID appSecret:dingdingSecretKey redirectURL:@"http://mobile.umeng.com/social"];
}

#pragma mark- 初始化bugly，bugly用于检测程序线上或线下出现的崩溃

- (void)initBugly{

    [Bugly startWithAppId:@""];

}


- (void)initWeiBoSDK
{
    LYLog(@"initWeiBoSDK");
    
    [WeiboSDK enableDebugMode:YES];
    BOOL isSuccess =  [WeiboSDK registerApp:@"3315867836"];
    if(isSuccess){
        LYLog(@"微博注册成功！");
    }else{
        LYLog(@"微博注册失败！");
    }
}

- (void)initTencentQQLogin
{
    LYLog(@"initTencentQQLogin");
    
    NSString *appid = @"1105837388";
    _tencentOAuth = [[TencentOAuth alloc]initWithAppId:appid andDelegate:self];
    
    LYLog(@"_tencentOAuth : %@" , self.tencentOAuth);
    
}

- (void)initweixin
{
    
  BOOL isSuccess =   [WXApi registerApp:@"wx6885ece91f0b3ea7"];
    if(isSuccess){
        LYLog(@"微信注册成功！");
    }else{
        LYLog(@"微信注册失败！");
    }
}



#pragma mark 键盘退出
- (void)initKeyBoardManager
{
    
    IQKeyboardManager *manager =  [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.toolbarTintColor = [UIColor colorWithRed:0.12 green:0.51 blue:0.97 alpha:1.00];
}


#pragma mark --
- (void)applicationWillResignActive:(UIApplication *)application {
  
    
    
    
}

#pragma mark -- 已经进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//         [[UIApplication alloc] setApplicationIconBadgeNumber:0];
         [application setApplicationIconBadgeNumber:0];
          [JPUSHService setBadge:0];
}

#pragma mark --
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [[UNUserNotificationCenter alloc] removeAllPendingNotificationRequests];
    
    _isVXPaySuceess = NO;
    NSString *key = [[NSUserDefaults standardUserDefaults] objectForKey:@"支付返回"];
    if ([key isEqualToString:@"微信返回"]) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 *NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (!_isVXPaySuceess) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCheckVxPaySuccess object:nil];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"支付返回"];
            }
        });
    }
    
   
}

#pragma mark -- 苏醒
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   
}

#pragma mark -- 即将被杀死
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma masrk-微博第三方登陆，此方法用于控制程序跳转，如果不添加此方法，点击关闭按钮程序会闪退
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
//    if ([Growing handleUrl:url]) // 请务必确保该函数被调用
//    {
//        return YES;
//    }
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    return [WeiboSDK handleOpenURL:url delegate:self];
    
}
#pragma mark -- 钉钉

+(BOOL)openDingTalkUrl:(NSString*) targetUrl{
    if (targetUrl.length == 0) {
        return false;
    }
    NSString *url = [NSString stringWithFormat:@"dingtalk://dingtalkclient/page/link?url=%@",
                     [targetUrl urlEncodeUsingEncoding:NSUTF8StringEncoding]];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}



#pragma mark -- 支付宝

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    LYLog(@"url  : %@ options : %@"  , url , options);
    
    if ([[options objectForKey:UIApplicationOpenURLOptionsSourceApplicationKey] isEqualToString:@"com.sina.weibo"]) {
        return  [WeiboSDK handleOpenURL:url delegate:self];
    }
    if ([[options objectForKey:UIApplicationOpenURLOptionsSourceApplicationKey] isEqualToString:@"com.tencent.mqq"]) {
        return    [TencentOAuth HandleOpenURL:url];;
    }
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        WEAKSELF;
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            LYLog(@"result = %@",resultDic);
            LYLog(@"options 支付宝支付!");
            
            NSString *resultStatus = resultDic[@"resultStatus"];
            if(resultStatus.intValue == 9000){
                if (weakSelf.orderDetailVC) {
                      [weakSelf.orderDetailVC zhifubaoPay:YES];
                }
                if (weakSelf.orderFormVC) {
                     [weakSelf.orderFormVC zhifubaoPay:YES];
                }
                if (weakSelf.renewOrderVC) {
                     [weakSelf.renewOrderVC zhifubaoPay:YES];
                }
            }else{
                if (weakSelf.orderDetailVC) {
                    [weakSelf.orderDetailVC zhifubaoPay:NO];
                }
                if (weakSelf.orderFormVC) {
                    [weakSelf.orderFormVC zhifubaoPay:NO];
                }
                if (weakSelf.renewOrderVC) {
                    [weakSelf.renewOrderVC zhifubaoPay:NO];
                }
            }
        }];
    }
    if ([[options objectForKey:UIApplicationOpenURLOptionsSourceApplicationKey] isEqualToString:@"com.tencent.xin"]) {
        self.isVXPaySuceess = YES;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"支付返回"];
        return [WXApi handleOpenURL:url delegate:self];
    }
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    
    return result;
}

- (void)onResp:(BaseResp *)resp
{
    //支付返回结果，实际支付结果需要去微信服务器端查询
    if([resp isKindOfClass:[PayResp class]]){
        LYLog(@"PayResp : %@" , resp);
        NSString *strMsg ;
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"微信支付结果：成功！";
                LYLog(@"微信支付成功－PaySuccess，retcode = %d", resp.errCode);
                if (self.orderDetailVC) {
                     [self.orderDetailVC weixinPay:YES];
                }
                if (self.orderFormVC) {
                    [self.orderFormVC weixinPay:YES];
                }
                if (self.renewOrderVC) {
                     [self.renewOrderVC weixinPay:YES];
                }
                break;
            default:
                if (self.orderDetailVC) {
                     [self.orderDetailVC weixinPay:NO];
                }
                if (self.orderFormVC) {
                    [self.orderFormVC weixinPay:NO];
                }
                if (self.renewOrderVC) {
                    [self.renewOrderVC weixinPay:NO];
                }
               
                strMsg = [NSString stringWithFormat:@"微信支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                LYLog(@"微信支付错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
    
    //微信登录
    if([resp isKindOfClass:[SendAuthResp class]]){
        
        SendAuthResp *authResp = (SendAuthResp*)resp;
        LYLog(@"SendAuthResp : %@ code :%@" , authResp , authResp.code);

        NSString *strMsg = [NSString stringWithFormat:@"登录结果"];
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"微信登录结果：成功！";
                LYLog(@"微信登录成功－PaySuccess，retcode = %d", resp.errCode);
                //回调
                [self.loginVC weichatLogin:authResp];
                break;
            default:
                strMsg = [NSString stringWithFormat:@"微信支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                LYLog(@"微信登录错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
}

#pragma mark-iOS 11.0 _WKWebview

+ (void)progressWKContentViewCrash {
    if (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)) {
        const char *className = @"WKContentView".UTF8String;
        Class WKContentViewClass = objc_getClass(className);
        SEL isSecureTextEntry = NSSelectorFromString(@"isSecureTextEntry");
        SEL secureTextEntry = NSSelectorFromString(@"secureTextEntry");
        BOOL addIsSecureTextEntry = class_addMethod(WKContentViewClass, isSecureTextEntry, (IMP)isSecureTextEntryIMP, "B@:");
        BOOL addSecureTextEntry = class_addMethod(WKContentViewClass, secureTextEntry, (IMP)secureTextEntryIMP, "B@:");
        if (!addIsSecureTextEntry || !addSecureTextEntry) {
            NSLog(@"WKContentView-Crash->修复失败");
        }
    }
    
}

BOOL isSecureTextEntryIMP(id sender, SEL cmd) {
    return NO;
}

BOOL secureTextEntryIMP(id sender, SEL cmd) {
    return NO;
}

@end
