//
//  AlipayOrderInfoRequest.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "AlipayOrderInfoRequest.h"
#import "AlipayOrderInfoResponse.h"


@implementation AlipayOrderInfoRequest

- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    
    [self.queryParameters setValue:self.fromtype forKey:@"fromtype"];
    [self.queryParameters setValue:self.versioncode forKey:@"versioncode"];
    [self.queryParameters setValue:self.devicenum forKey:@"devicenum"];
    [self.queryParameters setValue:self.orderNo forKey:@"orderNO"];
    [self.queryParameters setValue:self.orderType forKey:@"orderType"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    
    return [AlipayOrderInfoResponse class];
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX_PAY,LYZ_ALIPAY_ORDER];
//}

@end
