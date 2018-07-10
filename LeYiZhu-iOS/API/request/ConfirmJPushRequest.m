//
//  ConfirmJPushRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "ConfirmJPushRequest.h"
#import "ConfirmJPushResponse.h"

@implementation ConfirmJPushRequest

- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters{
    
    [self.queryParameters setValue:self.jpushlogid forKey:@"jpushlogid"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters{
    
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [ConfirmJPushResponse class];
}



@end
