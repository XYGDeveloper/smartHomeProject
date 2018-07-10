//
//  ApiResponse.m
//  Qqw
//
//  Created by zagger on 16/8/18.
//  Copyright © 2016年 gao.jian. All rights reserved.
//

#import "ApiResponse.h"

@interface ApiResponse ()

/**
 *  api请求返回的状态码
 */
@property (nonatomic, copy, readwrite) NSString *code;

/**
 *  api请求返回的http状态码
 */
@property (nonatomic, assign, readwrite) NSInteger httpCode;

/**
 *  api请求返回的说明信息，如“请求成功”、“登陆失败等”
 */
@property (nonatomic, copy, readwrite) NSString *msg;

@end

@implementation ApiResponse

+ (instancetype)responseWithTask:(NSURLSessionTask *)task response:(id)responseObject error:(NSError *)error {
    ApiResponse *response = [[ApiResponse alloc] init];
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        response.code = responseObject[@"returncode"];
        response.msg = responseObject[@"msg"];
    }
    
    if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        response.httpCode = httpResponse.statusCode;
    }
    return response;
}

- (NSString *)msg {
    if (!_msg || _msg.length <= 0) {
        return @"您的网络好像有点问题";
    }
    return _msg;
}

@end
