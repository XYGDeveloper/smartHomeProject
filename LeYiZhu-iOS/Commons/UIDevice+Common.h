//
//  UIDevice+Common.h
//  Zhuzhu
//
//  Created by zagger on 15/12/15.
//  Copyright © 2015年 www.globex.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Scale(a) ((a)/[UIDevice ScreenScale])

#define kScreenWidth [UIScreen mainScreen].bounds.size.width //屏幕宽
#define kScreenHeight [UIScreen mainScreen].bounds.size.height //屏幕高

static CGFloat const ScreenSizeUnKnown = 0;//未知
static CGFloat const ScreenSizeIphone4 = 3.5;//3.5寸,iPhone4,4s
static CGFloat const ScreenSizeIphone5 = 4.0;//4.0寸,iPhone5,5c,5s
static CGFloat const ScreenSizeIphone6 = 4.7;//4.7寸,iphone6
static CGFloat const ScreenSizeIphone6P = 5.5;//5.5寸,iphone6plus

@interface UIDevice (Common)

#pragma mark - 系统、版本、名称等
//返回系统版本号
+ (CGFloat)SystemVersion;

//返回当前app名称
+ (NSString *)AppName;

//返回当前app版本号
+ (NSString *)AppVersion;

//返回当前app build版本号
+ (NSString *)AppBuildVersion;

//返回设备id
+ (NSString *)DeviceIdentifier;

//返回当前设备名称，如：iPhone 6
+ (NSString *)DeviceName;


#pragma mark - 屏幕分辨率、尺寸
//返回当前屏分辨率
+ (CGSize)ScreenResolution;

//返回屏幕分辨率，格式“高x宽”，如“960x640”
+ (NSString *)ScreenResolutionHxW;

//返回屏幕分辨率，格式“宽x高”，如“640x960”
+ (NSString *)ScreenResolutionWxH;

//屏幕尺寸
+ (CGFloat)ScreenInch;

//屏幕scale
+ (CGFloat)ScreenScale;


#pragma mark - 本地信息相关：运营商、国家、语言等
//返回当前手机的移动运营商
+ (NSString *)MobileOperator;

//国家
+ (NSString *)LocalCountry;

//语言
+ (NSString *)LocalLanguage;


#pragma mark - 破解越狱


/**
 *  判断设备是否越狱，判断方法根据apt和Cydia.app的path来判断
 *
 *  @return Yes for jailbroken, No for not
 */
+ (BOOL)isJailbroken;

/**
 *  判断你的App是否被破解
 *
 *  @return Yes for 破解, No for not
 */
+ (BOOL)isPirated;

@end
