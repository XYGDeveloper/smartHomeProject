//
//  IICommons.h
//  XiaMiMusic
//
//  Created by 陈 雪峰 on 15/3/29.
//  Copyright (c) 2015年 LostVoices. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "UIColor+RGBColor.h"
#import "UUID.h"
#import "CommonSettingMacros.h"
#import "LYZThemeMacros.h"

#define VersionCode @"1.2.171222"//线上环境
#define DeviceNum  ([UUID getUUID])
#define FromType @"2"


#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT     [UIScreen mainScreen].bounds.size.height
#define  SCREEN_SCALE   [UIScreen mainScreen].scale

#define WEAKSELF typeof(self) __weak weakSelf = self;

#define UIColorFromRGBAInHex(rgbValue, alphaValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define RGB(A,B,C)     [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0]

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

#define UI_IS_LANDSCAPE         ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight)
#define UI_IS_IPAD              ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define UI_IS_IPHONE            ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define UI_IS_IPHONE4           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height < 568.0)
#define UI_IS_IPHONE5           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
//判断iphone6

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)


//判断iphone6+

#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define UI_IS_IOS8_AND_HIGHER   ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)


#define weakify(var) __weak typeof(var) ZGWeak_##var = var;

#define strongify(var) \
_Pragma("clang  diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = ZGWeak_##var; \
_Pragma("clang diagnostic pop")


typedef void (^EventCallBack)(int event,id object);



@interface IICommons : NSObject

+(BOOL)isSystemVersionIOS8;

BOOL isSystemVersionIOS7();


+ (void)setPersistenceData:(id)object withKey:(id)key;
+ (id)getPersistenceDataWithKey:(id)key;
+ (NSString*)getPersistenceStringWithKey:(id)key;
+ (int)getPersistenceIntegerWithKey:(id)key;
+ (double)getPersistenceDoubleWithKey:(id)key;
+ (float)getPersistenceFloatWithKey:(id)key;
+ (void)removePersistenceDataForKey:(id)key;

+ (BOOL)valiMobile:(NSString *)mobile;
+ (BOOL)isValidateEmail:(NSString *)email;
+ (BOOL)validateIdentityCard: (NSString *)identityCard;
+ (BOOL)validateUserName:(NSString *)name;
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay; //比较日期大小
+ (BOOL)validateIDCardNumber:(NSString *)value; //身份证校验
+ (NSNumber *)numberHexString:(NSString *)aHexString;

@end

@interface UIView (Feed)

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, readonly) CGFloat right;
@property (nonatomic, readonly) CGFloat bottom;

@property (nonatomic, retain) id userObject;

@end

@interface NSString(LYZ)

+(NSString*)removeFloatAllZero:(NSString*)string;

-(CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width;

-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing
                                           textColor:(UIColor *)textcolor
                                            textFont:(UIFont *)font;

- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;

@end






