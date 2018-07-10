//
//  DetectUserStayRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "DetectUserStayRequest.h"
#import "DetectUserStayResponse.h"

@implementation DetectUserStayRequest

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
    return [DetectUserStayResponse class];
}




@end
