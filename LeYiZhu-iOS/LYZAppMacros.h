//
//  LYZAppMacros.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/31.
//  Copyright © 2016年 lyz. All rights reserved.
//

#ifndef LYZAppMacros_h
#define LYZAppMacros_h


#define KEY_USERNAME_PASSWORD @"com.smarthome.app.usernamepassword"
#define KEY_USERNAME @"com.smarthome.app.username"
#define KEY_PASSWORD @"com.smarthome.app.password"

//版本号 //设备号


#define HistoryCityArray @"HistoryCityArray"

#define SystemNavBarTitleColor [UIColor colorWithRed:0.05 green:0.48 blue:0.99 alpha:1.00]

#define NavBarColor_iOS [UIColor colorWithRed:0.05 green:0.48 blue:0.99 alpha:1.00]
//#define NavBarColor [UIColor colorWithHexString:@"#1A191F"]

#define NavBarColor [UIColor blackColor]

#define NavBarTitleColor [UIColor whiteColor]

#define YellowColor [UIColor colorWithRed:0.98 green:0.79 blue:0.19 alpha:1.00]

//屏幕的宽&高
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

//通知
#define NotificationCenter [NSNotificationCenter defaultCenter]

//字体大小
#define kFont(value) [UIFont systemFontOfSize:(value)]

//主题颜色
#define KTintColor [UIColor colorFromCycRGB:@"0DB9ED"]

//int转字符串
#define kIntString(name) [NSString stringWithFormat:@"%d",name]


//浅灰色背景
#define kBackgroundGrayColor [UIColor colorWithRed:0.961 green:0.961 blue:0.961 alpha:1]


#define kDeepBlueColor [UIColor colorWithRed:0.092 green:0.114 blue:0.331 alpha:1]


#define Scheme @"com.lyz.smarthome"
///LevelDB 数据库 key
#define kLevelDB_UserInfo @"UserInfo"

#define CustomerServiceNum @"400-967-0533" //客服电话

#define AlertCallServiceTitle @"为您拨打客服电话？"
#define GuidLink @"https://static.smartlyz.com/app/checkInGuid/checkInGuid.html"
#define AboutLYZ @"https://static.smartlyz.com/app/knowlyz/knowlyz.html"
#define InviteFriend @"https://static.smartlyz.com/app/invite/invite_friends.html"
#define VipRules @"https://static.smartlyz.com/app/lyzvip/viprule.html"
#define Vipregulations @"https://static.smartlyz.com/app/lyzvip/vipgrade.html"
#define AutoOpenDoorGuid @"https://static.smartlyz.com/app/openThedoor/ios.html"

//推送通知
#define kNotificationOrderDetailKey @"freshOrderDetail"
#define kNotificationStayPlanList @"freshStayPlanList"
#define kNotificationShowSearch  @"showSearchView"
#define kNotificationCheckVxPaySuccess @"CheckVXPaySuccessNotiKey"
#define kNotificationJoinVip        @"JoinVipNotification"

//数据保存
#define kMineInfoKey  @"AllMineInfo"

//无钥匙开锁
#define kAutoOpenDoorKey @"AutoOpenDoor"

#endif /* LYZAppMacros_h */
