//
//  UserLoginByMobileRequest.m
//  LeYiZhu-iOS
//
//  Created by L on 2017/3/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "UserLoginByMobileRequest.h"
#import "UseLoginBycache.h"
@implementation UserLoginByMobileRequest


- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    [self.queryParameters setValue:self.phone forKey:@"phone"];
    [self.queryParameters setValue:self.captcha forKey:@"captcha"];
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
    
    return [UseLoginBycache class];
    
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_LoginByCache];
//}




@end
