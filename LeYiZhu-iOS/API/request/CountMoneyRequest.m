//
//  CountMoneyRequest.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "CountMoneyRequest.h"
#import "CountMoneyResponse.h"

@implementation CountMoneyRequest

- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    [self.queryParameters setValue:self.roomTypeID forKey:@"roomTypeID"];
    [self.queryParameters setValue:self.payNum forKey:@"payNum"];
    [self.queryParameters setValue:self.checkInDate forKey:@"checkInDate"];
    [self.queryParameters setValue:self.checkOutDate forKey:@"checkOutDate"];
    [self.queryParameters setValue:self.coupondetatilid forKey:@"coupondetatilid"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    
    return [CountMoneyResponse class];
}




@end
