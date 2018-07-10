//
//  Utils.m
//  Qqw
//
//  Created by zagger on 16/8/17.
//  Copyright © 2016年 gao.jian. All rights reserved.
//

#import "Utils.h"
#import "UIDevice+Common.h"
@implementation Utils


+ (BOOL)shouldShowGuidePage {
//    if (![AFNetworkReachabilityManager sharedManager].reachable) {
//        return NO;
//    }
    
    NSString *appverstion = [UIDevice AppVersion];
    NSString *cachedVersion = [[NSUserDefaults standardUserDefaults] stringForKey:@"kCachedAppVersionKey"];
    
    if (!cachedVersion || [appverstion compare:cachedVersion] == NSOrderedDescending) {
        return YES;
    }
    return NO;
}

+ (void)updateCachedAppVersion {
    NSString *appverstion = [UIDevice AppVersion];
    [[NSUserDefaults standardUserDefaults] setObject:appverstion forKey:@"kCachedAppVersionKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end


@implementation UIColor (extension)

+ (UIColor *)rgb:(NSString *)rgbHex{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != rgbHex)
    {
        NSScanner *scanner = [NSScanner scannerWithString:rgbHex];
        (void) [scanner scanHexInt:&colorCode];
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode);
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}


@end

