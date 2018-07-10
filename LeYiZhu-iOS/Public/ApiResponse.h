//
//  ApiResponse.h
//  Qqw
//
//  Created by zagger on 16/8/18.
//  Copyright © 2016年 gao.jian. All rights reserved.
//

#import <Foundation/Foundation.h>

//请求成功的状态码
static NSString *kCodeSuccess = @"01";
//表示当前操作需要会员资格，而用户目前还不是会员
static NSString *kCodeNotVip = @"1102";

/**
 *  api请求结果信息，主要包括返回的状态码，说明信息等
 */
@interface ApiResponse : NSObject

/**
 *  api请求返回的状态码
 */
@property (nonatomic, copy, readonly) NSString *code;

/**
 *  api请求返回的http状态码
 */
@property (nonatomic, assign, readonly) NSInteger httpCode;

/**
 *  api请求返回的说明信息，如“请求成功”、“登陆失败等”
 */
@property (nonatomic, copy, readonly) NSString *msg;

+ (instancetype)responseWithTask:(NSURLSessionTask *)task response:(id)responseObject error:(NSError *)error;

@end
