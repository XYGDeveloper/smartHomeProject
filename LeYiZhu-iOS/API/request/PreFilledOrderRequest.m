//
//  PreFilledOrderRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/11.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "PreFilledOrderRequest.h"
#import "PreFilledOrderResponse.h"

@implementation PreFilledOrderRequest

- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [PreFilledOrderResponse class];
}



@end
