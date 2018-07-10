//
//  bindByPhoneRequest.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/29.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "bindByPhoneRequest.h"
#import "bindByPhoneResponse.h"

@implementation bindByPhoneRequest

- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    
    [self.queryParameters setValue:self.fromtype forKey:@"fromtype"];
    [self.queryParameters setValue:self.versioncode forKey:@"versioncode"];
    [self.queryParameters setValue:self.devicenum forKey:@"devicenum"];
    [self.queryParameters setValue:self.thirdID forKey:@"thirdID"];
    [self.queryParameters setValue:self.phone forKey:@"phone"];
    [self.queryParameters setValue:self.captcha forKey:@"captcha"];
    [self.queryParameters setValue:self.type forKey:@"type"];
    [self.queryParameters setValue:self.nickName forKey:@"nickName"];
    [self.queryParameters setValue:self.facePath forKey:@"facePath"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [bindByPhoneResponse class];
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_BIND_PHONE];
//}

@end
