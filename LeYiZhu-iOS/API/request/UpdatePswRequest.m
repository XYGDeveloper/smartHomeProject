//
//  UpdatePswRequest.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/12.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "UpdatePswRequest.h"
#import "UpdatePswResponse.h"

@implementation UpdatePswRequest
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
    [self.queryParameters setValue:self.oldPsw forKey:@"oldPwd"];
    [self.queryParameters setValue:self.nPsw forKey:@"newPwd"];
    
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [UpdatePswResponse class];
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_UPDATE_PSW];
//}


@end
