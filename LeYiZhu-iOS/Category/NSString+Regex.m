//
//  NSString+Regex.m
//  LeYiZhu-iOS
//
//  Created by mac on 2016/12/19.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "NSString+Regex.h"

@implementation NSString (Regex)


- (BOOL)isValidateByRegex:(NSString *)regex{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

- (BOOL)isMobile
{
  
    //移动
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    //联通
    NSString * CM = @"^1(3[0-9]|4[57]|5[0-35-9]|7[01678]|8[0-9])\\d{8}$";
    NSString * CU = @"^1((3[0-2]|5[256]|8[56])\\d|709)\\d{7}$";
    //电信
    NSString * CT = @"^1(3[34]|53|77|700|8[019])\\d{8}$";
    //小灵通
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    if (([self isValidateByRegex:CM])
        || ([self isValidateByRegex:CU])
        || ([self isValidateByRegex:CT])
        || ([self isValidateByRegex:PHS])
        || ([self isValidateByRegex:MOBILE])
        
        )
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

- (BOOL) isPassword:(NSString *)password
{
    
    NSString *pwd = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
    NSPredicate *regextestPwd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pwd];
    
    if ([regextestPwd evaluateWithObject:password]) {
        
        return YES;
    }
    return NO;
}


- (BOOL)isPassword
{
    NSString* number=@"^[0-9a-zA-Z]{6,18}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:self];
    
}

- (BOOL)isEmail
{
    
    NSString* number=@"^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:self];
    
}


@end
