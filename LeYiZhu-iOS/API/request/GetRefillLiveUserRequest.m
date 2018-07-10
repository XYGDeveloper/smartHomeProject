//
//  GetRefillLiveUserRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetRefillLiveUserRequest.h"
#import "GetRefillLiveUserResponse.h"

@implementation GetRefillLiveUserRequest

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
    [self.queryParameters setValue:self.orderNO forKey:@"orderNO"];
    [self.queryParameters setValue:self.orderType forKey:@"orderType"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [GetRefillLiveUserResponse class];
}

- (NSString *) getApiUrl
{
    return [NSString stringWithFormat:@"%@/%@",LYZ_PREFIX,Search_Rootrenative];
}


@end
