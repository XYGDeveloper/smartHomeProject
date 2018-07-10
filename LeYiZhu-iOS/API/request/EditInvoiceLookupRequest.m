//
//  EditInvoiceLookupRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "EditInvoiceLookupRequest.h"
#import "EditInvoiceLookupResponse.h"

@implementation EditInvoiceLookupRequest


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
    [self.queryParameters setValue:self.lookupID forKey:@"id"];
    [self.queryParameters setValue:self.type forKey:@"type"];
    [self.queryParameters setValue:self.lookUp forKey:@"lookUp"];
    [self.queryParameters setValue:self.taxNumber forKey:@"taxNumber"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [EditInvoiceLookupResponse class];
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_EDIT_LOOKUP];
//}



@end
