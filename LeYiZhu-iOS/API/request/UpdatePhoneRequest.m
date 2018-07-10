//
//  UpdatePhoneRequest.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/9.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "UpdatePhoneRequest.h"
#import "UpdatePhoneResponse.h"

@implementation UpdatePhoneRequest

- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    
    [self.queryParameters setValue:self.fromtype forKey:@"fromtype"];
    [self.queryParameters setValue:self.versioncode forKey:@"versioncode"];
    [self.queryParameters setValue:self.devicenum forKey:@"devicenum"];
    [self.queryParameters setValue:self.appUserID forKey:@"appUserID"];
    [self.queryParameters setValue:self.phone forKey:@"phone"];
    [self.queryParameters setValue:self.captcha forKey:@"captcha"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [UpdatePhoneResponse class];
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_UPDATE_PHONE];
//}


@end
