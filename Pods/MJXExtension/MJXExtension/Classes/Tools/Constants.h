//
//  Constants.h
//  LCheck
//
//  Created by wangxiaohu on 15/12/8.
//  Copyright © 2015年 com.sofn.youhao. All rights reserved.
//


#ifndef Constants_h
#define Constants_h


//MARK: -- 日志输出

#ifdef DEBUG
# define ConsoleLog(fmt, ...) NSLog((@"[ClassName] = %@\n" "[FunctionName] = %s\n" "[Line] = %d \n" fmt), NSStringFromClass([self class]), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define ConsoleLog(...);
#endif




//MARK: -- 屏幕尺寸及相关配置尺寸

#define SCREEN_BOUNDS              [[UIScreen mainScreen] bounds]
#define SCREEN_WIDTH               CGRectGetWidth(SCREEN_BOUNDS)
#define SCREEN_HEIGHT              CGRectGetHeight(SCREEN_BOUNDS)
//以375和667的尺寸来获取的比率scale
#define SCREEN_WidthScale          SCREEN_WIDTH/375
#define SCREEN_heightScale         SCREEN_HEIGHT/667
// ==64.0
#define SCREEN_NaviHight           (CGRectGetHeight(self.navigationController.navigationBar.bounds)+20)
// ==48.0
#define SCREEN_TabarHight          CGRectGetHeight(self.tabBarController.tabBar.bounds)



//MARK: -- 颜色

// 16进制颜色值 以0x开头，如：0x4db2fa
#define COLOR_FromHex(a)            [UIColor colorWithRed:(((a & 0xFF0000) >> 16))/255.0 green:(((a &0xFF00) >>8))/255.0 blue:((a &0xFF))/255.0 alpha:1.0]
// 一般背景
#define COLOR_General               [UIColor colorWithRed:250 green:250 blue:250 alpha:1.0]
// 灰暗背景
#define COLOR_GrayGeneral           [UIColor colorWithRed:235.0 green:235.0 blue:235.0 alpha:1.0]
// RGB颜色值
#define COLOR_WithRAB(r,g,b)        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
// RGB颜色值，带透明度
#define COLOR_WithRAB_A(r,g,b,a)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
// 弹框底色
#define COLOR_BounceView            [[UIColor blackColor] colorWithAlphaComponent:0.3]
// 纯白色
#define COLOR_White          [UIColor whiteColor]
// 默认TableView的颜色
#define COLOR_TableViewBG    COLOR_WithRAB(242,242,242)
// 标题颜色
#define COLOR_TextTitle      COLOR_WithRAB(94,94,94)
// 详情颜色
#define COLOR_TextDetail     COLOR_WithRAB(193,193,193)
// Header颜色
#define COLOR_Header         COLOR_WithRAB(79,79,79)
// Footer颜色
#define COLOR_Footer         COLOR_WithRAB(176,176,176)
// 分割线颜色
#define COLOR_LineColor      COLOR_WithRAB(246,246,246)
// 灰暗字体颜色
#define COLOR_TextGray     COLOR_WithRAB(237,237,237)




//MARK: -- 字体

// 系统字体
#define SystemFont(x) [UIFont systemFontOfSize:x]
// 粗体
#define BoldFont(x) [UIFont boldSystemFontOfSize:x]
// 主页标题字体
#define FONT_NaviTitle    [UIFont boldSystemFontOfSize:18.0f]
// 标题字体
#define FONT_TextTitle    [UIFont systemFontOfSize:16.0f]
// 详情字体
#define FONT_TextDetail   [UIFont systemFontOfSize:14.0f]
// Header字体
#define FONT_Header       [UIFont systemFontOfSize:18.0f]
// Footer字体
#define FONT_Footer       [UIFont systemFontOfSize:15.0f]




//MARK: -- 通知

// 发送通知
#define Notification_Post(name) [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];

// 删除所有通知
#define Notification_RemoveAll(observer) [[NSNotificationCenter defaultCenter] removeObserver:observer];



#pragma mark -- 其他

//  AppDelegate
#define CurrentAppDelegate   ((AppDelegate *)[UIApplication sharedApplication].delegate)

// 沙盒Document文件的路径
/*
 * 这个等同于 [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
 */
#define DocumentsPath        [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

// 文件路径
#define FilePathName(fileName)                  [DocumentsPath stringByAppendingString:fileName];



//MARK: -- 相关方法

// 类的初始化
#define Init(Class) [[Class alloc] init];

// 根据Xib创建控制器
#define InitControllerWithXib(x) [[NSClassFromString(x) alloc] initWithNibName:x bundle:nil];

// 创建SB根控制器
#define InitRootControllerWithStoryboard(name)    [[UIStoryboard storyboardWithName:name bundle:nil]instantiateInitialViewController];

// 根据Storyboard创建控制器
#define InitControllerWithStoryboard(name,identifier)    [[UIStoryboard storyboardWithName:name bundle:nil] instantiateViewControllerWithIdentifier:identifier];

// 读取单nib文件
#define LoadNibName(name) [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] firstObject];

// 生成图片
#define KImage(imageName)  [UIImage imageNamed:imageName]

// 系统版本
#define  SystemVersion  [[[UIDevice currentDevice] systemVersion] floatValue]

// 当前应用版本
#define CurrentVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// 获取AppStore路径
/*
 * name:  将app名每个字的拼音全称用"-"链接，拼接成字符串
 * appId: 将iTunes Connect 生成的appId，转成字符串
 */
#define AppStorePath(name , appId) [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/%@/id%@?mt=8", name , appId]


// 字符串安全取值
#define SafeString(a) ([(a) isKindOfClass:[NSString class]] && [(a) length] > 0) ? [(a) description] : @""

// 提示文字
#define NO_MORE @"没有更多数据"



//MARK: -- 相关定义


// UserDefaults
#define UserDefaults [NSUserDefaults standardUserDefaults]
// weakSelf
#define weakSelf(self) __weak typeof(self) weakSelf = self;
// strongSelf
#define strongSelf(weakSelf) __weak typeof(weakSelf) strongSelf = weakSelf;
// 字符串转URL
#define URLString(string) [NSURL URLWithString:string]



#endif /* Constants_h */
