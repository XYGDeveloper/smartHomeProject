//
//  GetUserOrdesRequest.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/1/21.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "GetUserOrdersRequest.h"
#import "GetUserOrdersResponse.h"

@implementation GetUserOrdersRequest
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
    [self.queryParameters setValue:self.orderStatus forKey:@"orderStatus"];
    [self.queryParameters setValue:self.limit forKey:@"limit"];
    [self.queryParameters setValue:self.pages forKey:@"pages"];
    
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [GetUserOrdersResponse class];
}



@end
