//
//  GetCouponListRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/3.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetCouponListRequest.h"
#import "GetCouponListResponse.h"

@implementation GetCouponListRequest

- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    [self.queryParameters setValue:self.roomprice forKey:@"roomprice"];
    [self.queryParameters setValue:self.couponstatus forKey:@"couponstatus"];
    [self.queryParameters setValue:self.limit forKey:@"limit"];
    [self.queryParameters setValue:self.pages forKey:@"pages"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [GetCouponListResponse class];
}




@end
