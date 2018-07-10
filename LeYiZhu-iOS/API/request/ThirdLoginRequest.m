//
//  ThirdLoginRequest.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "ThirdLoginRequest.h"
#import "ThirdLoginResponse.h"

@implementation ThirdLoginRequest
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
    return [ThirdLoginResponse class];
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_THIRD_LOGIN];
//}


@end
