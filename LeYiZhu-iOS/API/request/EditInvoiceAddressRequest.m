//
//  EditInvoiceAddressRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "EditInvoiceAddressRequest.h"
#import "EditInvoiceAddressResponse.h"

@implementation EditInvoiceAddressRequest

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
    [self.queryParameters setValue:self.invoiceAddressID forKey:@"id"];
    [self.queryParameters setValue:self.phone forKey:@"phone"];
    [self.queryParameters setValue:self.province forKey:@"province"];
    [self.queryParameters setValue:self.city forKey:@"city"];
    [self.queryParameters setValue:self.area forKey:@"area"];
    [self.queryParameters setValue:self.address forKey:@"address"];
    [self.queryParameters setValue:self.recipient forKey:@"recipient"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [EditInvoiceAddressResponse class];
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_EDIT_INVOICEADDRESS];
//}

@end
