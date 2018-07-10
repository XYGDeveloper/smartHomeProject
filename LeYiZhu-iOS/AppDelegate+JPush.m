//
//  AppDelegate+JPush.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/10/20.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AppDelegate+JPush.h"
#import <AdSupport/AdSupport.h>
#import "LYZPushOperationCenter.h"
#import "XFAlertView.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#define JPushKey @"f181ca84e010c9351d55931e"

@implementation AppDelegate (JPush)

-(void)setupJpush:(nullable NSDictionary *)launchOptions{
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionNone;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    [JPUSHService setupWithOption:launchOptions appKey:JPushKey
                          channel:@"App Store"
                 apsForProduction:YES
            advertisingIdentifier:advertisingId];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
}

#pragma mark - JPush Delegate

#pragma mark --JPush
//注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

//实现注册APNs失败接口（可选）
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max

//添加处理APNs通知回调方法   JPUSHRegisterDelegate
// ios 10 support 处于前台时接收到通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        if (userInfo)
        {
            // 取得Extras字段内容
//            NSDictionary *extras = [userInfo valueForKey:@"extras"];
//            //服务端中Extras字段，key是自己定义的,需要与极光的附加字段一致
//            // 若传入字段的值为1，进入相应的页面
//            NSString *forWardTarget = extras[@"forWardTarget"];
//            if ([forWardTarget isEqualToString:@"0011"]) {
//
//                if (self.topay) {
//                    self.topay([extras valueForKey:@"orderNO"], [extras valueForKey:@"orderType"]);
//                }
//                XFAlertView *alert = [[XFAlertView alloc]initWithTitle:@"您有一个未支付订单"
//                                                                   Msg:@""
//                                                        CancelBtnTitle:@"暂时忽略"
//                                                            OKBtnTitle:@"前往支付"
//                                                                   Img:[UIImage imageNamed:@"unpay_alert"]];
//                alert.delegate = self;
//                [alert show];
//            }
       }
//        [self RecieveExtrasOfNotificationWithUserInfo:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

- (void)alertView:(XFAlertView *)alertView didClickTitle:(NSString *)title{
    if ([title isEqualToString:@"前往支付"]) {
        [[LYZPushOperationCenter instance] jumpToTargetWithOrderNo:[[NSUserDefaults standardUserDefaults] objectForKey:@"orderNO"] orderType:[[NSUserDefaults standardUserDefaults] objectForKey:@"orderType"]];
    }
}

// iOS 10 Support  点击处理事件
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];

        if (userInfo){
        
//            [self ClickExtrasOfNotificationWithUserInfo:userInfo];
            [JPUSHService handleRemoteNotification:userInfo];
            completionHandler(UIBackgroundFetchResultNewData);
            NSDictionary *extras = [userInfo valueForKey:@"extras"];
            NSString *forWardTarget = extras[@"forWardTarget"];
            if ([forWardTarget isEqualToString:@"0011"]) {
                [[NSUserDefaults standardUserDefaults] setObject:[extras valueForKey:@"orderNO"] forKey:@"orderNO"];
                [[NSUserDefaults standardUserDefaults] setObject:[extras valueForKey:@"orderType"] forKey:@"orderType"];
                XFAlertView *alert = [[XFAlertView alloc]initWithTitle:@"您有一个未支付订单" Msg:@""CancelBtnTitle:@"暂时忽略"OKBtnTitle:@"前往支付"Img:[UIImage imageNamed:@"unpay_alert"]];
                alert.delegate = self;
                [alert show];
            }
        }
        
    }
    completionHandler();  // 系统要求执行这个方法
}

#endif


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
//    [self RecieveExtrasOfNotificationWithUserInfo:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);

    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    //服务端中Extras字段，key是自己定义的,需要与极光的附加字段一致
    // 若传入字段的值为1，进入相应的页面
    NSString *forWardTarget = extras[@"forWardTarget"];
    if(application.applicationState == UIApplicationStateActive) {
        
        if ([forWardTarget isEqualToString:@"0011"]) {
            [[NSUserDefaults standardUserDefaults] setObject:[extras valueForKey:@"orderNO"] forKey:@"orderNO"];
            [[NSUserDefaults standardUserDefaults] setObject:[extras valueForKey:@"orderType"] forKey:@"orderType"];
            XFAlertView *alert = [[XFAlertView alloc]initWithTitle:@"您有一个未支付订单" Msg:@""CancelBtnTitle:@"暂时忽略"OKBtnTitle:@"前往支付"Img:[UIImage imageNamed:@"unpay_alert"]];
            alert.delegate = self;
            [alert show];
        }
        
    }else if(application.applicationState == UIApplicationStateInactive) {
       
        if ([forWardTarget isEqualToString:@"0011"]) {
            [[NSUserDefaults standardUserDefaults] setObject:[extras valueForKey:@"orderNO"] forKey:@"orderNO"];
            [[NSUserDefaults standardUserDefaults] setObject:[extras valueForKey:@"orderType"] forKey:@"orderType"];
            XFAlertView *alert = [[XFAlertView alloc]initWithTitle:@"您有一个未支付订单" Msg:@""CancelBtnTitle:@"暂时忽略"OKBtnTitle:@"前往支付"Img:[UIImage imageNamed:@"unpay_alert"]];
            alert.delegate = self;
            [alert show];
        }
        
    }else if(application.applicationState == UIApplicationStateBackground) {
        
        //APP没有运行，推送过来消息的处理
        if ([forWardTarget isEqualToString:@"0011"]) {
            
            [[LYZPushOperationCenter instance] jumpToTargetWithOrderNo:[extras valueForKey:@"orderNO"] orderType:[extras valueForKey:@"orderType"]];
        }
    }
}

#pragma mark - 自定义消息

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    [self RecieveExtrasOfNotificationWithUserInfo:userInfo];
}

#pragma mark - 消息处理

// 点击推送消息处理
- (void)ClickExtrasOfNotificationWithUserInfo:(NSDictionary *)userInfo
{
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *forWardTarget = extras[@"forWardTarget"];
    if ([forWardTarget isEqualToString:@"0011"]) {
        [[NSUserDefaults standardUserDefaults] setObject:[extras valueForKey:@"orderNO"] forKey:@"orderNO"];
        [[NSUserDefaults standardUserDefaults] setObject:[extras valueForKey:@"orderType"] forKey:@"orderType"];
        XFAlertView *alert = [[XFAlertView alloc]initWithTitle:@"您有一个未支付订单" Msg:@""CancelBtnTitle:@"暂时忽略"OKBtnTitle:@"前往支付"Img:[UIImage imageNamed:@"unpay_alert"]];
        alert.delegate = self;
        [alert show];
    }
}

// 接受推送消息处理
- (void)RecieveExtrasOfNotificationWithUserInfo:(NSDictionary *)userInfo
{
    if (userInfo)
    {
        // 取得Extras字段内容
        NSDictionary *extras = [userInfo valueForKey:@"extras"];
        //服务端中Extras字段，key是自己定义的,需要与极光的附加字段一致
        // 若传入字段的值为1，进入相应的页面
        NSString *forWardTarget = extras[@"forWardTarget"];
        LYLog(@"点击推送  调用此方法 ---> %@",userInfo);
        if ([forWardTarget isEqualToString:@"0002"] ) {
            [[LYZPushOperationCenter instance] handleCode:forWardTarget];
        }
        if ([forWardTarget isEqualToString:@"0020"]) {
            [[LYZPushOperationCenter instance] pushCouponToUser: [extras valueForKey:@"couponimgurl"]];
        }
        if ([forWardTarget isEqualToString:@"0010"]) {
            [[LYZPushOperationCenter instance] beginGetCurrentSoundFrequecy:extras];
        }
        if ([forWardTarget isEqualToString:@"0011"]) {
            [[NSUserDefaults standardUserDefaults] setObject:[extras valueForKey:@"orderNO"] forKey:@"orderNO"];
            [[NSUserDefaults standardUserDefaults] setObject:[extras valueForKey:@"orderType"] forKey:@"orderType"];
            XFAlertView *alert = [[XFAlertView alloc]initWithTitle:@"您有一个未支付订单" Msg:@""CancelBtnTitle:@"暂时忽略"OKBtnTitle:@"前往支付"Img:[UIImage imageNamed:@"unpay_alert"]];
            alert.delegate = self;
            [alert show];
        }
    }
}


@end
