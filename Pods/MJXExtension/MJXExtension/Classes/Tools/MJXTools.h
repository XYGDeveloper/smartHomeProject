//
//  MJXTools.h
//  Enterprise
//
//  Created by SG on 2017/4/6.
//  Copyright © 2017年 com.sofn.lky.enterprise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *const TIME_Date = @"yyyy.MM.dd";
static NSString *const TIME_Date_HH = @"yyyy-MM-dd HH:mm";
static NSString *const TIME_ALL = @"yyyy-MM-dd HH:mm:ss";

typedef NS_ENUM(NSInteger,MD5Type) {
      MD5Default = 0,
      MD5Lowercase,
      MD5Uppercase
};

@interface MJXTools : NSObject

/**
 以合适的尺寸来切图
 @param origImage 原图
 @param fitSize 切成的size尺寸
 @return 结果图
 */

+ (UIImage *)getImageFromImage:(UIImage *)origImage fitSize:(CGSize)fitSize;
/**
 以合适的尺寸调整图片
 @param image 原来的图片
 @param size 绘制图片的大小
 @return 结果图
 */

+ (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size;


/**
 过滤HTML标签
 @param originHtmlStr 传入web的字符串
 @return 结果字符串
 */
+ (NSString *)filterHtmlTag:(NSString *)originHtmlStr;


/**
 手机号码正则匹配
 @param mobileNum 传出手机号字符串
 @return YES:匹配成功, NO:不匹配
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;


/**
 邮箱正则匹配
 @param email 传入的邮箱
 @return YES:是邮箱 NO，不是邮箱
 */
+ (BOOL)validateEmail:(NSString *)email;


/**
 文字的自适应尺寸
 @param string 需要显示的文本
 @param font 文字的大小
 @param constraintSize 预设size大小
 @return 适配显示的size大小
 */
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font constraintSize:(CGSize)constraintSize;

/**
 MD5加密

 @param str 需要加密的字符串
 @param type 结果类型 MD5Default:默认类型(大小写混合),MD5Lowercase:全是小写,MD5Uppercase:全是大写
 @return 结果字符串
 */
+ (NSString *)MD5HexDigest:(NSString *)str type:(MD5Type)type;


/**
 判断空字符串

 @param string 需要判断的字符串
 @return YES:是空字符串(可能输入的全为空格)，NO:有实在的字
 */
+ (BOOL)validateNullString:(NSString *)string;


/**
  日期转化成字符串

 @param date 需要转化的时间
 @param format 结果格式 
     1.TIME_Date：年月日，
     2.TIME_ALL：年月日，时分秒，
     3.也可能自定义格式按照"yyyy-MM-dd HH:mm:ss"来自定义
 @return TIME_Date
 */
+ (NSString *)timeStringFromDate:(NSDate *)date  format:(NSString *)format;


/**
 时间截的转化

 @param str 需要传入的时间截字符串
 @param format 返回的格式同上
 @return 返回时间字符串
 */
+ (NSString *)timeStringTimeWithString:(NSString *)str format:(NSString *)format;



/**
 时间字符串转化成时间截

 @param dateStr 时间字符串
 @param format 时间格式
 @return 时间截字符串
 */
+ (NSString *)timeStringWithTime:(NSString *)dateStr format:(NSString *)format;


/**
 字符串转日期

 @param str 需要转化的时间字符串
 @param format 返回的格式同上
 @return 时间NSDate对象
 */
+ (NSDate *)dateWithTimeString:(NSString *)str format:(NSString *)format;


/**
  距离现在的时间
 @param str 需要传入的时间截字符串
 @return 结果
 */
+ (NSString *)distanceTimeWithBeforeTimeStr:(NSString *)str;

/**
  获取当前时间截

 @return 时间截字符串
 */
+ (NSString *)getCurrentTimeInterval;


/**
 比较日期大小
 @param largeDate 大日期字符串
 @param smallDate 小日期字符串
 @param format 格式同上
 @return  NSOrderedAscending:大于   NSOrderedSame:相等   NSOrderedDescending:小于
 */
+ (NSComparisonResult)sureLagerDate:(NSString *)largeDate compareSmallDate:(NSString *)smallDate format:(NSString *)format;

/**
 10进制转16进制
 @param tmpid 10进制数
 @return 16进制的字符串
 */
+ (NSString *)ToHex:(long long int)tmpid;


/**
 16进制转10进制
 @param OriStr 16进制的字符串
 @return 10进制字符串
 */
+ (NSString *)HexTo:(NSString *)OriStr;


/**
 判断字符串是否为纯数字

 @param string 数字型字符串
 @return YES:是纯数字 NO:不是纯数字
 */
+ (BOOL)isPureLongLong:(NSString*)string;


/**
 对象的数据化

 @param obj 传入带属性的对象
 @return 以属性名为Key的字典，类似于KVC和MJExtension
 */
+ (NSDictionary *)getObjectData:(id)obj;

/**
 参数转Json字符串
 @param obj 数组或字典
 @return Json字符串
 */
+ (NSString *)dictionaryToJson:(id)obj;


/**
 生成参数
 @param keys 字典的key数组
 @param values 字典的values数组 以数组顺序赋值
 @return 返回参数
 */
+ (NSDictionary *)createParameterWith:(NSArray <NSString *> *)keys values:(NSArray <id> *)values;


/**
   判断TextFields数组是否有空值
   注: 如果一个没有值，会以占位字符串提示无值。

 @param textFields textFields数组
 @return YES:表示有空值。
 */
+ (BOOL)isHaveNullTextFelds:(NSArray <UITextField *> *)textFields;


/**
 按钮数组中能单选一个

 @param buttons 按钮数组
 @param sender 选择的那一个,也就是seleted属性,sender为YSE,其他为NO
 */
+ (void)handleButtons:(NSArray <UIButton *> *)buttons seletedButton:(UIButton *)sender;


/**
 获取当前最顶部的控制器

 @return 最顶部的控制器
 */
+ (UIViewController *)currentViewController;


/**
  过滤文本中的表情
 
// @return 过滤后的字符串
// */
//+ (NSString *)disable_emoji:(NSString *)text;

/**
 判断字符串中是否有表情
 
 @return BOOL 是否有表情
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

/**
 图片旋转了的问题
 
 @return image 可用的图片
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;

@end
