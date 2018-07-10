//
//  UserResetPswRequest.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/11/30.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "UserResetPswRequest.h"
#import "UserResetPswResponse.h"


@implementation UserResetPswRequest

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
    
    return [UserResetPswResponse class];
}

//- (NSString *) getApiUrl{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_RESET_PSW];
//}


@end
