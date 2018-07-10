//
//  ExchangeCouponRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "ExchangeCouponRequest.h"
#import "ExchangeCouponResponse.h"

@implementation ExchangeCouponRequest

- (NSMutableDictionary *) getHeaders{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters{
    
    [self.queryParameters setValue:self.code forKey:@"code"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters{
    
    return self.pathParameters;
}

- (Class) getResponseClazz{
    
    return [ExchangeCouponResponse class];
}

@end
