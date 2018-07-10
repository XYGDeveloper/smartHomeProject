//
//  getOrderTimeRequest.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/13.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "GetOrderTimeRequest.h"
#import "GetOrderTimeResponse.h"




@implementation GetOrderTimeRequest

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
   
    
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [GetOrderTimeResponse class];
}

- (NSString *) getApiUrl
{
    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_ORDER_TIME];
}


@end
