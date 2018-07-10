//
//  ChangePwdRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/5/8.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "ChangePwdRequest.h"
#import "ChangePwdResponse.h"

@implementation ChangePwdRequest

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
    [self.queryParameters setValue:self.roomID forKey:@"roomID"];
    
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [ChangePwdResponse class];
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_CHANGE_PSW];
//}

@end
