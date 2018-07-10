//
//  UpdateContactsRequest.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/9.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "UpdateContactsRequest.h"
#import "UpdateContactsResponse.h"

@implementation UpdateContactsRequest


- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    
    [self.queryParameters setValue:self.fromtype forKey:@"fromtype"];
    [self.queryParameters setValue:self.versioncode forKey:@"versioncode"];
    [self.queryParameters setValue:self.devicenum forKey:@"devicenum"];
    [self.queryParameters setValue:self.contactID forKey:@"contactsID"];
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
    return [UpdateContactsResponse class];
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_UPDATE_CONTACTS];
//}



@end
