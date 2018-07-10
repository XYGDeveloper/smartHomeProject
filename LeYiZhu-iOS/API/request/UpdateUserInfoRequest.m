//
//  UpdateUserInfoRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "UpdateUserInfoRequest.h"
#import "UpdateUserInfoResponse.h"

@implementation UpdateUserInfoRequest

- (NSMutableDictionary *) getHeaders{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters{
    
    [self.queryParameters setValue:self.nickname forKey:@"nickname"];
    [self.queryParameters setValue:self.facepath forKey:@"facepath"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters{
    
    return self.pathParameters;
}

- (Class) getResponseClazz{
    
    return [UpdateUserInfoResponse class];
}

@end
