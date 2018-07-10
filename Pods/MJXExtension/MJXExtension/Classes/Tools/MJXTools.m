//
//  MJXTools.m
//  Enterprise
//
//  Created by SG on 2017/4/6.
//  Copyright © 2017年 com.sofn.lky.enterprise. All rights reserved.
//

#import "MJXTools.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>

@implementation MJXTools

#pragma mark -- 以合适的尺寸来切图
+ (UIImage *)getImageFromImage:(UIImage *)origImage fitSize:(CGSize)fitSize{
    CGSize size = origImage.size;
    CGFloat with = size.width/fitSize.width;
    CGFloat hith = size.height/fitSize.height;
    //剪切框的frame;
    CGRect myImageRect;
    if (with<=hith) {
        CGFloat clipHiht =size.width*fitSize.height/fitSize.width;
        myImageRect=CGRectMake(0,size.height/2-clipHiht/2, size.width, clipHiht);
    }else{
        CGFloat clipWith =size.height*fitSize.width/fitSize.height;
        myImageRect = CGRectMake(size.width/2-clipWith/2,0,clipWith,size.height);
    }
    CGImageRef imageRef = origImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef,myImageRect);
    UIGraphicsBeginImageContext(fitSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context,myImageRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    return smallImage;
}

#pragma mark --  以合适的尺寸调整图片
+ (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;   //返回的就是已经改变的图片
}


#pragma mark -- 过滤HTML标签
+ (NSString *)filterHtmlTag:(NSString *)originHtmlStr{
    if (!originHtmlStr||[originHtmlStr isKindOfClass:[NSNull class]]) {
        return @"未知时间";
    }
    NSString *result = nil;
    NSRange arrowTagStartRange = [originHtmlStr rangeOfString:@"<"];
    if (arrowTagStartRange.location != NSNotFound) { //如果找到
        NSRange arrowTagEndRange = [originHtmlStr rangeOfString:@">"];
        result = [originHtmlStr stringByReplacingCharactersInRange:NSMakeRange(arrowTagStartRange.location, arrowTagEndRange.location - arrowTagStartRange.location + 1) withString:@""];
        return [self filterHtmlTag:result];    //递归，过滤下一个标签
    }else{
        result = [originHtmlStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];  // 过滤&nbsp等标签

    }
    return result;
}

#pragma mark -- 手机号码正则匹配
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark -- 邮箱正则匹配
+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


#pragma mark -- 文字的自适应尺寸
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font constraintSize:(CGSize)constraintSize {

    CGRect rect = [string boundingRectWithSize:constraintSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil];

    return rect.size;
}

#pragma mark -- MD5加密
+ (NSString *)MD5HexDigest:(NSString *)str type:(MD5Type)type
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    unsigned leng = (unsigned)[str length];
    CC_MD5(original_str,leng, result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02X", result[i]];
    }
    if (type == MD5Lowercase) {
        return [hash lowercaseString];
    }else if(type == MD5Uppercase){
        return [hash uppercaseString];
    }else{
        return  hash;
    }
}

#pragma mark -- 判断空字符串
+ (BOOL)validateNullString:(NSString *)string{

    BOOL result = NO;
    NSCharacterSet *set=[NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimedString=[string stringByTrimmingCharactersInSet:set];
     if (trimedString.length == 0) {
         result = YES;
     }
    return result;
}

#pragma mark -- 日期转化成字符串
+ (NSString *)timeStringFromDate:(NSDate *)date  format:(NSString *)format{
    NSDateFormatter *timeform=[[NSDateFormatter alloc]init];
    //@"yyyy-MM-dd  HH:mm:ss"
    [timeform setDateFormat:format];
    NSString *timeStr = [timeform stringFromDate:date];
    return timeStr;
}

#pragma mark -- 时间戳的转化
+ (NSString *)timeStringTimeWithString:(NSString *)str format:(NSString *)format{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:str.integerValue/1000];//时间需要注意需不需要
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    
    NSString *returnString =[formatter stringFromDate:date];
    
    return returnString;
}



#pragma mark -- 时间字符串转化成时间截
+ (NSString *)timeStringWithTime:(NSString *)dateStr format:(NSString *)format{
   NSDate *date = [MJXTools dateWithTimeString:dateStr format:format];
    NSTimeInterval interval = [date timeIntervalSince1970];
    return [@(interval) stringValue];
}


#pragma mark -- 字符串转日期
+ (NSDate *)dateWithTimeString:(NSString *)str format:(NSString *)format{
    
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    
    [dateformater setDateFormat:format];
    NSDate *date  = [[NSDate alloc] init];
    date = [dateformater dateFromString:str];
    return date;
}

#pragma mark -- 距离现在的时间
+ (NSString *)distanceTimeWithBeforeTimeStr:(NSString *)str
{
    NSTimeInterval beTime= str.integerValue/1000;//时间需要注意需不需要
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    double distanceTime = now - beTime;
    NSString * distanceStr;
    
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    NSString * timeStr = [df stringFromDate:beDate];
    
    [df setDateFormat:@"dd"];
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];
    
    if (distanceTime < 60) {//小于一分钟
        distanceStr = @"刚刚";
    }else if (distanceTime <60*60) {//时间小于一个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
    }else if(distanceTime <24*60*60 && [nowDay integerValue] == [lastDay integerValue]){//时间小于一天
        distanceStr = [NSString stringWithFormat:@"今天 %@",timeStr];
    }else if(distanceTime<24*60*60*2 && [nowDay integerValue] != [lastDay integerValue]){
        
        if ([nowDay integerValue] - [lastDay integerValue] ==1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1)) {
            distanceStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
        }else{
            [df setDateFormat:@"MM-dd HH:mm"];
            distanceStr = [df stringFromDate:beDate];
        }
        
    }else if(distanceTime <24*60*60*365){
        [df setDateFormat:@"MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }else{
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
}

#pragma mark -- 获取当前时间截
+ (NSString *)getCurrentTimeInterval{
    NSDate *currentDate = [[NSDate date] dateByAddingTimeInterval:8*3600];
    
    NSTimeInterval interval = [currentDate timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.f",interval];
}

#pragma mark -- 比较日期大小
+ (NSComparisonResult)sureLagerDate:(NSString *)largeDate compareSmallDate:(NSString *)smallDate format:(NSString *)format{
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    
    [dateformater setDateFormat:format];
    NSDate *large = [[NSDate alloc] init];
    NSDate *small = [[NSDate alloc] init];
    
    large = [dateformater dateFromString:largeDate];
    small = [dateformater dateFromString:smallDate];
    NSComparisonResult result = [large compare:small];
    return result;
}

#pragma mark -- 10进制转16进制
+(NSString *)ToHex:(long long int)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i =0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
    }
    str =[@"Wb" stringByAppendingString:str];
    return str;
}

#pragma mark -- 16进制转10进制
+ (NSString *)HexTo:(NSString *)OriStr{
    NSString *OriginStr = [OriStr substringFromIndex:2];

    //MARK: -- 十六制数转化成十进制数
    NSString * temp10 = [NSString stringWithFormat:@"%lu",strtoul([OriginStr UTF8String],0,16)];
    return temp10;
}


#pragma mark -- 判断字符串是否为纯数字
+ (BOOL)isPureLongLong:(NSString*)string{
    NSScanner *scanStr = [NSScanner scannerWithString:string];
    long long val;
    return[scanStr scanLongLong:&val] && [scanStr isAtEnd];
}


#pragma mark -- 对象的数据化
+ (NSDictionary *)getObjectData:(id)obj{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value== nil)
        {
            value = [NSNull null];
        }else{
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    return dic;
}
+ (id)getObjectInternal:(id)obj
{
    if([obj isKindOfClass:[NSString class]]||[obj isKindOfClass:[NSNumber class]]||[obj isKindOfClass:[NSNull class]]){
        return obj;
    }
    if([obj isKindOfClass:[NSArray class]]){
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++){
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]]atIndexedSubscript:i];
        }
        return arr;
    }
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in  objdic.allKeys){
            [dic  setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
    
}

#pragma mark -- 字典转Json字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



#pragma mark -- 生成参数
+ (NSDictionary *)createParameterWith:(NSArray <NSString *> *)keys values:(NSArray <id> *)values{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    for (int i = 0 ; i < keys.count; i ++) {
        [parameter setObject:values[i] forKey:keys[i]];
    }
    return  parameter;
}


#pragma mark -- 判断TextFields数组是否有空值
+ (BOOL)isHaveNullTextFelds:(NSArray <UITextField *> *)textFields{
    
    for (UITextField *textField in textFields) {
        if ([MJXTools validateNullString:textField.text]) {
            
            NSString *messge = @"输入信息有误";
            if (textField.placeholder) {
                messge =  [NSString stringWithFormat:@"%@不能为空", textField.placeholder];
            }

            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:messge delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return YES;
        }
    }
    return NO;
}

#pragma mark -- 按钮数组中能单选一个
+ (void)handleButtons:(NSArray <UIButton *> *)buttons seletedButton:(UIButton *)sender{
    for (UIButton *button in buttons) {
        if (button == sender) {
            sender.selected = YES;
        }else{
            button.selected = NO;
        }
    }
}

#pragma mark -- 获取当前最顶部的控制器

+ (UIViewController *)currentViewController {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = [(UINavigationController *)vc visibleViewController];
        } else if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = [(UITabBarController *)vc selectedViewController];
        }
    }
    return vc;
}

#pragma mark -- 过滤文本
+ (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

#pragma mark -- 判断字符串中是否有表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar high = [substring characterAtIndex: 0];
                                
                                // Surrogate pair (U+1D000-1F9FF)
                                if (0xD800 <= high && high <= 0xDBFF) {
                                    const unichar low = [substring characterAtIndex: 1];
                                    const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
                                    
                                    if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                                        returnValue = YES;
                                    }
                                    
                                    // Not surrogate pair (U+2100-27BF)
                                } else {
                                    if (0x2100 <= high && high <= 0x27BF){
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

#pragma mark -- 图片旋转了的问题
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


@end
