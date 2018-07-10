//
//  CommitRefillLiveOrderRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "CommitRefillLiveOrderRequest.h"
#import "CommitRefillLiveOrderResponse.h"

@implementation CommitRefillLiveOrderRequest

- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    [self.queryParameters setValue:self.phone forKey:@"phone"];
    [self.queryParameters setValue:self.invoiceType forKey:@"invoiceType"];
    [self.queryParameters setValue:self.invoiceInfo forKey:@"invoiceInfo"];
    [self.queryParameters setValue:self.childOrderIds forKey:@"childOrderIds"];
    [self.queryParameters setValue:self.isOpenPrivacy forKey:@"isOpenPrivacy"];
    [self.queryParameters setValue:self.coupondetatilid forKey:@"coupondetatilid"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}



- (Class) getResponseClazz{
    
    return [CommitRefillLiveOrderResponse class];
}

//- (NSString *) getApiUrl{
//    
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_REFILLORDER_COMMIT];
//}



@end
