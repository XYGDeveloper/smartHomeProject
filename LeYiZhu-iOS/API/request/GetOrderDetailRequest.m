//
//  GetOrderDetails.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "GetOrderDetailRequest.h"
#import "GetOrderDetailResponse.h"

@implementation GetOrderDetailRequest

- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    
    [self.queryParameters setValue:self.fromtype forKey:@"fromtype"];
    [self.queryParameters setValue:self.versioncode forKey:@"versioncode"];
    [self.queryParameters setValue:self.devicenum forKey:@"devicenum"];
    [self.queryParameters setValue:self.orderNO forKey:@"orderNO"];
    [self.queryParameters setValue:self.orderType forKey:@"orderType"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [GetOrderDetailResponse class];
}

- (NSString *) getApiUrl
{
    return [NSString stringWithFormat:@"%@/%@",LYZ_PREFIX,Search_Rootrenative];
}


@end
