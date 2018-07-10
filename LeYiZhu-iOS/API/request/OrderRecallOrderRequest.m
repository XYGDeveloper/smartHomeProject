//
//  OrderRecallOrderRequest.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/1/21.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "OrderRecallOrderRequest.h"
#import "OrderRecallOrderResponse.h"

@implementation OrderRecallOrderRequest

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
    return [OrderRecallOrderResponse class];
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_RECALL_ORDER];
//}


@end
