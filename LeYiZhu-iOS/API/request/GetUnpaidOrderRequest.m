//
//  GetUnpaidOrderRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/5/8.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetUnpaidOrderRequest.h"
#import "GetUnpaidOrderResponse.h"

@implementation GetUnpaidOrderRequest

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
   
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [GetUnpaidOrderResponse class];
}

@end
