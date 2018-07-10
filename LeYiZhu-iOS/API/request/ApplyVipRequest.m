//
//  ApplyVipRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "ApplyVipRequest.h"
#import "ApplyVipResponse.h"

@implementation ApplyVipRequest


- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    [self.queryParameters setValue:self.username forKey:@"username"];
    [self.queryParameters setValue:self.idcard forKey:@"idcard"];
    [self.queryParameters setValue:self.email forKey:@"email"];
    [self.queryParameters setValue:self.invitecode forKey:@"invitecode"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [ApplyVipResponse class];
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_APPLY_VIP];
//}


@end
