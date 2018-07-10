//
//  SecurityUtil.h
//  Smile
//
//  Created by 蒲晓涛 on 12-11-24.
//  Copyright (c) 2012年 BOX. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "SecurityUtil.h"
#import "GTMBase64.h"
#import "NSData+AES.h"


#define C2I(c) ((c >= '0' && c<='9') ? (c-'0') : ((c >= 'a' && c <= 'z') ? (c - 'a' + 10): ((c >= 'A' && c <= 'Z')?(c - 'A' + 10):(-1))))
@implementation SecurityUtil

#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString * )input { 
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]; 
    data = [GTMBase64 encodeData:data]; 
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
}

+ (NSString*)decodeBase64String:(NSString * )input { 
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]; 
    data = [GTMBase64 decodeData:data]; 
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
} 

+ (NSString*)encodeBase64Data:(NSData *)data {
	data = [GTMBase64 encodeData:data]; 
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
}

+ (NSString*)decodeBase64Data:(NSData *)data {
	data = [GTMBase64 decodeData:data]; 
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
}

#pragma mark - AES加密
//将string转成带密码的data
+(NSString*)encryptAESDataToHexString:(NSString*)string app_key:(NSString*)key
{
    //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [data AES128EncryptWithKey:key];
    Byte *bytes = (Byte *)[encryptedData bytes];
    NSLog(@"%@", encryptedData);
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[encryptedData length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    NSLog(@"%@", hexStr);
    NSLog(@"%@", hexStr.uppercaseString);
    return hexStr.uppercaseString;
}

+(NSString*)encryptAESDataToBase64:(NSString*)string app_key:(NSString*)key
{
    //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [data AES128EncryptWithKey:key];
    Byte *bytes = (Byte *)[encryptedData bytes];
    NSLog(@"%@", encryptedData);
    NSLog(@"加密后的字符串 :%@",[encryptedData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]);
    
    return [encryptedData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

#pragma mark - 转16进制
-(NSString *)hexStringFromData:(NSData *)data{
    Byte *bytes = (Byte *)[data bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}


#pragma mark - 16进制转data
-(NSData *)convert:(NSString *)str

{
    
    const char* cs = str.UTF8String;
    
    int count = strlen(cs);
    
    int8_t bytes[count / 2];
    
    for(int i = 0; i<count; i+=2)
    {
        char c1 = *(cs + i);
        char c2 = *(cs + i + 1);
        if(C2I(c1) >= 0 && C2I(c2) >= 0){
            bytes[i / 2] = C2I(c1) * 16 + C2I(c2);
        }else{
            return nil;
        }
    }
    return [NSData dataWithBytes:bytes length:count / 2];
}

#pragma mark - AES解密
//将带密码的data转成string
+(NSString*)decryptAESStringFromBase64:(NSString *)string  app_key:(NSString*)key
{
    NSData *EncryptData = [GTMBase64 decodeString:string]; //解密前进行GTMBase64编码
    //使用密码对data进行解密
    NSData *decryData = [EncryptData AES128DecryptWithKey:key];
    
    //将解了密码的nsdata转化为nsstring
    NSString *str = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return str;
}

+(NSString*)decryptAESStringFromHexString:(NSString *)string  app_key:(NSString*)key
{
    //16进制转data
    const char* cs = string.UTF8String;
    
    int count = strlen(cs);
    
    int8_t bytes[count / 2];
    
    for(int i = 0; i<count; i+=2)
    {
        char c1 = *(cs + i);
        char c2 = *(cs + i + 1);
        if(C2I(c1) >= 0 && C2I(c2) >= 0){
            bytes[i / 2] = C2I(c1) * 16 + C2I(c2);
        }else{
            return nil;
        }
    }
    NSData * newData = [NSData dataWithBytes:bytes length:count / 2];
    NSLog(@"%@", newData);
    //NSData *EncryptData = [GTMBase64 decodeString:string]; //解密前进行GTMBase64编码
    //使用密码对data进行解密
    NSData *decryData = [newData AES128DecryptWithKey:key];
    //将解了密码的nsdata转化为nsstring
    NSString *str = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return str;
}

@end
