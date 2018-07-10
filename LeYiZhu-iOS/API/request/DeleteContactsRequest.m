//
//  DeleteContactsRequest.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/18.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "DeleteContactsRequest.h"
#import "DeleteContactsResponse.h"

@implementation DeleteContactsRequest

- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    
    [self.queryParameters setValue:self.fromtype forKey:@"fromtype"];
    [self.queryParameters setValue:self.versioncode forKey:@"versioncode"];
    [self.queryParameters setValue:self.devicenum forKey:@"devicenum"];
    [self.queryParameters setValue:self.contactsID forKey:@"contactsID"];
    
    
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [DeleteContactsResponse class];
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_DELETE_CONTACTS];
//}



@end
