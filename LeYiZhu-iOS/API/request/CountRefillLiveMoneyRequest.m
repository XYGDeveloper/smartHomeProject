//
//  CountRefillLiveMoneyRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "CountRefillLiveMoneyRequest.h"
#import "CountRefillLiveMoneyResponse.h"

@implementation CountRefillLiveMoneyRequest

- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    [self.queryParameters setValue:self.childOrderIds forKey:@"childOrderIds"];
    [self.queryParameters setValue:self.coupondetatilid forKey:@"coupondetatilid"];
    return self.queryParameters;
    
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}



- (Class) getResponseClazz
{
    return [CountRefillLiveMoneyResponse class];
}



@end
