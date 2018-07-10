//
//  CreateContactsRequest.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "CreateContactsRequest.h"
#import "CreateContactsResponse.h"

@implementation CreateContactsRequest

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
    [self.queryParameters setValue:self.name forKey:@"name"];
    [self.queryParameters setValue:[self.paperworkType stringValue]forKey:@"paperworkType"];
    [self.queryParameters setValue:self.paperworkNum forKey:@"paperworkNum"];
    [self.queryParameters setValue:self.sex forKey:@"sex"];
    [self.queryParameters setValue:self.phone forKey:@"phone"];
    
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [CreateContactsResponse class];
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_CREATE_CONTACTS];
//}



@end
