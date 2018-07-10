//
//  CreateWeChatOrderInfo.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "CreateWeChatOrderInfoRequest.h"
#import "CreateWeChatOrderResponse.h"

@implementation CreateWeChatOrderInfoRequest

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

- (NSMutableDictionary *) getPathParameters{
    
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [CreateWeChatOrderResponse class];
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX_PAY,LYZ_WECHAT_ORDER];
//}


@end
