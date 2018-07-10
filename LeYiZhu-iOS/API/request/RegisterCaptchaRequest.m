//
//  RegisterCaptchaRequest.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/11/28.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "RegisterCaptchaRequest.h"
#import "RegisterCaptchaResponse.h"

@implementation RegisterCaptchaRequest

- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    [self.queryParameters setValue:self.phone forKey:@"phone"];
    [self.queryParameters setValue:self.versioncode forKey:@"versioncode"];
    [self.queryParameters setValue:self.devicenum forKey:@"devicenum"];
    [self.queryParameters setValue:self.fromtype forKey:@"fromtype"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    
    return [RegisterCaptchaResponse class];
}

//- (NSString *) getApiUrl{
//
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_CAPTCHA];
//}




@end
