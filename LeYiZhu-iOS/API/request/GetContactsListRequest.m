//
//  GetContactsListRequest.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "GetContactsListRequest.h"
#import "GetContactsListResponse.h"

@implementation GetContactsListRequest

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
    return [GetContactsListResponse class];
}




@end
