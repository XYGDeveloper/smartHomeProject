//
//  UserRegisterRequest.m
//  NexPack
//
//  Created by levo on 15/9/16.
//  Copyright (c) 2015年 noa-labs. All rights reserved.
//

#import "UserRegisterRequest.h"
#import "UserRigisterResponse.h"

@implementation UserRegisterRequest


- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    [self.queryParameters setValue:self.phone forKey:@"phone"];
    [self.queryParameters setValue:self.password forKey:@"password"];
    [self.queryParameters setValue:self.captcha forKey:@"captcha"];
    [self.queryParameters setValue:self.fromtype forKey:@"fromtype"];
    [self.queryParameters setValue:self.versioncode forKey:@"versioncode"];
    [self.queryParameters setValue:self.devicenum forKey:@"devicenum"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    
    return [UserRigisterResponse class];
}

//- (NSString *) getApiUrl{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_REGISTER];
//}



@end
