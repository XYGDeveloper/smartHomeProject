//
//  UIDevice+Common.m
//  Zhuzhu
//
//  Created by zagger on 15/12/15.
//  Copyright © 2015年 www.globex.cn. All rights reserved.
//

#import "UIDevice+Common.h"
#import <sys/utsname.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
//#import <SSKeychain.h>

@implementation UIDevice (Common)

#pragma mark - 系统、版本、名称等
+ (CGFloat)SystemVersion{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (NSString *)AppName {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    if (!appName) {
        appName = [infoDictionary objectForKey:@"CFBundleName"];
    }
    return appName;
}

+ (NSString *)AppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)AppBuildVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}

+ (NSString *)DeviceIdentifier {
//    NSString *serviceKey = @"_U_DID";
//    NSString *accountKey = @"com.quanqiuwa";
//    NSString *identfier = [SSKeychain passwordForService:serviceKey account:accountKey];
//    if (!identfier) {
//        identfier = [[UIDevice currentDevice].identifierForVendor UUIDString];
//        [SSKeychain setPassword:identfier forService:serviceKey account:accountKey];
//    }
//    return identfier;
    return @"";
}

+ (NSString *)DeviceName {
    static NSString *deviceName = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        
        //iPhone
        if ([platform isEqualToString:@"iPhone1,1"])    deviceName = @"iPhone 2G";
        if ([platform isEqualToString:@"iPhone1,2"])    deviceName = @"iPhone 3G";
        if ([platform isEqualToString:@"iPhone2,1"])    deviceName = @"iPhone 3GS";
        if ([platform isEqualToString:@"iPhone3,1"])    deviceName = @"iPhone 4";
        if ([platform isEqualToString:@"iPhone3,2"])    deviceName = @"iPhone 4";
        if ([platform isEqualToString:@"iPhone3,3"])    deviceName = @"iPhone 4";
        if ([platform isEqualToString:@"iPhone4,1"])    deviceName = @"iPhone 4S";
        if ([platform isEqualToString:@"iPhone5,1"])    deviceName = @"iPhone 5";
        if ([platform isEqualToString:@"iPhone5,2"])    deviceName = @"iPhone 5";
        if ([platform isEqualToString:@"iPhone5,3"])    deviceName = @"iPhone 5C";
        if ([platform isEqualToString:@"iPhone5,4"])    deviceName = @"iPhone 5C";
        if ([platform isEqualToString:@"iPhone6,1"])    deviceName = @"iPhone 5S";
        if ([platform isEqualToString:@"iPhone6,2"])    deviceName = @"iPhone 5S";
        if ([platform isEqualToString:@"iPhone7,2"])    deviceName = @"iPhone 6";
        if ([platform isEqualToString:@"iPhone7,1"])    deviceName = @"iPhone 6Plus";
        if ([platform isEqualToString:@"iPhone8,1"])    deviceName = @"iPhone 6s";
        if ([platform isEqualToString:@"iPhone8,2"])    deviceName = @"iPhone 6s Plus";
        if ([platform isEqualToString:@"iPhone8,4"])    deviceName = @"iPhone SE";
        if ([platform isEqualToString:@"iPhone9,1"])    deviceName = @"iPhone 7";
        if ([platform isEqualToString:@"iPhone9,3"])    deviceName = @"iPhone 7";
        if ([platform isEqualToString:@"iPhone9,2"])    deviceName = @"iPhone 7 Plus";
        if ([platform isEqualToString:@"iPhone9,4"])    deviceName = @"iPhone 7 Plus";
        
        //iPod
        if ([platform isEqualToString:@"iPod1,1"])      deviceName = @"iPod Touch";
        if ([platform isEqualToString:@"iPod2,1"])      deviceName = @"iPod Touch 2G";
        if ([platform isEqualToString:@"iPod3,1"])      deviceName = @"iPod Touch 3G";
        if ([platform isEqualToString:@"iPod4,1"])      deviceName = @"iPod Touch 4G";
        if ([platform isEqualToString:@"iPod5,1"])      deviceName = @"iPod Touch 5G";
        if ([platform isEqualToString:@"iPod7,1"])      deviceName = @"iPod touch 6G";
        
        //iPad
        if ([platform isEqualToString:@"iPad1,1"])      deviceName = @"iPad";
        if ([platform isEqualToString:@"iPad2,1"])      deviceName = @"iPad 2";
        if ([platform isEqualToString:@"iPad2,2"])      deviceName = @"iPad 2";
        if ([platform isEqualToString:@"iPad2,3"])      deviceName = @"iPad 2";
        if ([platform isEqualToString:@"iPad2,4"])      deviceName = @"iPad 2";
        if ([platform isEqualToString:@"iPad3,1"])      deviceName = @"iPad 3";
        if ([platform isEqualToString:@"iPad3,2"])      deviceName = @"iPad 3";
        if ([platform isEqualToString:@"iPad3,3"])      deviceName = @"iPad 3";
        if ([platform isEqualToString:@"iPad3,4"])      deviceName = @"iPad 4";
        if ([platform isEqualToString:@"iPad3,5"])      deviceName = @"iPad 4";
        if ([platform isEqualToString:@"iPad3,6"])      deviceName = @"iPad 4";
        
        //iPad Air
        if ([platform isEqualToString:@"iPad4,1"])      deviceName = @"iPad Air";
        if ([platform isEqualToString:@"iPad4,2"])      deviceName = @"iPad Air";
        if ([platform isEqualToString:@"iPad4,3"])      deviceName = @"iPad Air";
        if ([platform isEqualToString:@"iPad5,3"])      deviceName = @"iPad Air 2";
        if ([platform isEqualToString:@"iPad5,4"])      deviceName = @"iPad Air 2";
        
        //iPad mini
        if ([platform isEqualToString:@"iPad2,5"])      deviceName = @"iPad mini";
        if ([platform isEqualToString:@"iPad2,6"])      deviceName = @"iPad mini";
        if ([platform isEqualToString:@"iPad2,7"])      deviceName = @"iPad mini";
        if ([platform isEqualToString:@"iPad4,4"])      deviceName = @"iPad mini 2";
        if ([platform isEqualToString:@"iPad4,5"])      deviceName = @"iPad mini 2";
        if ([platform isEqualToString:@"iPad4,6"])      deviceName = @"iPad mini 2";
        if ([platform isEqualToString:@"iPad4,7"])      deviceName = @"iPad mini 3";
        if ([platform isEqualToString:@"iPad4,8"])      deviceName = @"iPad mini 3";
        if ([platform isEqualToString:@"iPad4,9"])      deviceName = @"iPad mini 3";
        if ([platform isEqualToString:@"iPad5,1"])      deviceName = @"iPad mini 4";
        if ([platform isEqualToString:@"iPad5,2"])      deviceName = @"iPad mini 4";
        
        //iPad Pro
        if ([platform isEqualToString:@"iPad6,7"])      deviceName = @"iPad Pro (12.9 inch)";
        if ([platform isEqualToString:@"iPad6,8"])      deviceName = @"iPad Pro (12.9 inch)";
        if ([platform isEqualToString:@"iPad6,3"])      deviceName = @"iPad Pro (9.7 inch)";
        if ([platform isEqualToString:@"iPad6,4"])      deviceName = @"iPad Pro (9.7 inch)";
        
        //simulator
        if ([platform isEqualToString:@"i386"])         deviceName = @"Simulator";
        if ([platform isEqualToString:@"x86_64"])       deviceName = @"Simulator";
        
        if (!deviceName) {
            deviceName = platform;
        }
    });
    return deviceName;
}


#pragma mark - 屏幕分辨率、尺寸
+ (CGSize)ScreenResolution {
    return [UIScreen mainScreen].currentMode.size;
}

+ (NSString *)ScreenResolutionHxW {
    //屏幕分辨率，格式“高x宽”，如“960x640”
    CGSize size = [self ScreenResolution];
    return [NSString stringWithFormat:@"%fx%f", size.height, size.width];
}

+ (NSString *)ScreenResolutionWxH {
    //屏幕分辨率，格式“宽x高”，如“640x960”
    CGSize size = [self ScreenResolution];
    return [NSString stringWithFormat:@"%fx%f", size.width, size.height];
    
}

+ (CGFloat)ScreenInch {//屏幕尺寸
    static CGFloat inchSize = ScreenSizeUnKnown;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGSize size = [self ScreenResolution];
        if (CGSizeEqualToSize(size, CGSizeMake(640, 960)) || CGSizeEqualToSize(size, CGSizeMake(320, 480))) {
            inchSize = ScreenSizeIphone4;
        }
        else if (CGSizeEqualToSize(size, CGSizeMake(640, 1136))){
            inchSize = ScreenSizeIphone5;
        }
        else if (CGSizeEqualToSize(size, CGSizeMake(750, 1334))){
            inchSize = ScreenSizeIphone6;
        }
        else if (CGSizeEqualToSize(size, CGSizeMake(1242, 2208))){
            inchSize = ScreenSizeIphone6P;
        }
    });
    
    return inchSize;
}

+ (CGFloat)ScreenScale {
    //    if ([[UIScreen mainScreen] respondsToSelector:@selector(nativeScale)]) {
    //        return [UIScreen mainScreen].nativeScale;
    //    }
    return [UIScreen mainScreen].scale;
}




#pragma mark - 本地信息相关：运营商、国家、语言等
/**
 *  IMSI共有15位,MCC+MNC+MSIN,(MNC+MSIN=NMSI)
 *  MCC:MobileCountryCode,移动国家码,中国的是460
 *  MNC:MobileNetworkCode,移动网络码
 *  MSIN:MobileSubscriberIdentificationNumber
 */
+ (NSString *)MobileOperator {//移动运营商
    CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc]init];
    
    CTCarrier *carrier = [netInfo subscriberCellularProvider];
    return carrier.carrierName;
}

+ (NSString *)LocalCountry {//国家
    return [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
}

+ (NSString *)LocalLanguage {//语言
    return [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
}

#pragma mark - 破解越狱

//是否越狱
+ (BOOL)isJailbroken {
    NSString *cydiaPath = @"/Applications/Cydia.app";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        return YES;
    }
    
    /* apt */
    NSString *aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isPirated {
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    
    /* SC_Info */
    if (![[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/SC_Info", bundlePath]]) {
        return YES;
    }
    
    /* iTunesMetadata.​plist */
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/iTunesMetadata.​plist", bundlePath]]) {
        return YES;
    }
    
    return NO;
}


@end
