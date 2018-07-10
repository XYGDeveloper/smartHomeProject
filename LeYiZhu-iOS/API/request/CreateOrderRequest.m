//
//  CreateOrderRequest.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/7.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "CreateOrderRequest.h"
#import "CreateOrderResponse.h"

@implementation CreateOrderRequest

- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    [self.queryParameters setValue:self.roomTypeID forKey:@"roomTypeID"];
    [self.queryParameters setValue:self.checkInDate forKey:@"checkInDate"];
    [self.queryParameters setValue:self.checkOutDate forKey:@"checkOutDate"];
    [self.queryParameters setValue:self.payNum forKey:@"payNum"];
    [self.queryParameters setValue:self.phone forKey:@"phone"];
    [self.queryParameters setValue:self.checkIns forKey:@"checkIns"];
    [self.queryParameters setValue:self.invoiceInfo forKey:@"invoiceInfo"];
    [self.queryParameters setValue:self.invoiceType forKey:@"invoiceType"];
    [self.queryParameters setValue:self.isOpenPrivacy forKey:@"isOpenPrivacy"];
    [self.queryParameters setValue:self.coupondetatilid forKey:@"coupondetatilid"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [CreateOrderResponse class];
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_CREATE_ORDER];
//}



@end
