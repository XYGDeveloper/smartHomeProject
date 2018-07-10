//
//  ApiManager.m
//  Qqw
//
//  Created by zagger on 16/8/18.
//  Copyright © 2016年 gao.jian. All rights reserved.
//

#import "ApiManager.h"
#import "User.h"
#import "RequestLogger.h"
#import <AFHTTPSessionManager.h>

typedef void(^AFSuccessBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);
typedef void(^AFFailureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);

@interface ApiManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation ApiManager

+ (instancetype)sharedManager {
    static ApiManager *__manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager = [[ApiManager alloc] init];
    });
    return __manager;
}

- (id)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = 30;
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        AFJSONResponseSerializer *responseSerializer = (AFJSONResponseSerializer *)self.sessionManager.responseSerializer;
        AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        self.sessionManager.securityPolicy = securityPolicy;
        self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        if ([responseSerializer respondsToSelector:@selector(setRemovesKeysWithNullValues:)]) {
            [responseSerializer setRemovesKeysWithNullValues:YES];
        }
        NSMutableSet *set = [NSMutableSet setWithSet:self.sessionManager.responseSerializer.acceptableContentTypes];
        [set addObject:@"text/html"];
        [set addObject:@"text/json"];
        [set addObject:@"text/plain"];
        [set addObject:@"charset=utf-8"];
        [set addObject:@"Set-Cookie"];
        self.sessionManager.responseSerializer.acceptableContentTypes = set;
        
    }
    return self;
}

- (NSURLSessionDataTask *)requestWithCommand:(ApiCommand *)command
                   constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
                                     success:(void(^)(NSURLSessionDataTask *task, ApiCommand *command, id responseObject))success
                                     failure:(void(^)(NSURLSessionDataTask *task, ApiCommand *command, NSError *error))failure {
    
    NSMutableDictionary *prams = [NSMutableDictionary dictionaryWithDictionary:[self commonParameters]];
    if ([command.parameters isKindOfClass:[NSDictionary class]]) {
        [prams addEntriesFromDictionary:command.parameters];
    }
    
    
    NSDate *startDate = [NSDate date];
    
    __block ApiCommand *weakCmd = command;
    AFSuccessBlock sBlock = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [RequestLogger logResponsWithTask:task startTime:startDate responsObject:responseObject error:nil];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            success(task, weakCmd, responseObject);
        } else {
            failure(task, weakCmd, nil);
        }
    };
    
    AFFailureBlock fBlock = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [RequestLogger logResponsWithTask:task startTime:startDate responsObject:nil error:error];
        weakCmd.response = [ApiResponse responseWithTask:task response:nil error:nil];
        if (failure) {
            failure(task, weakCmd, error);
        }
    };
    
    
    //添加cookies
//    [Utils addCookiesForURL:[NSURL URLWithString:command.requestURLString]];
    
    NSURLSessionDataTask *dataTask = nil;
    if (command.method == QQWRequestMethodGet) {
        dataTask = [self.sessionManager GET:command.requestURLString parameters:prams success:sBlock failure:fBlock];
       
    }
    else if (command.method == QQWRequestMethodPost) {
        if (block) {
            dataTask = [self.sessionManager POST:command.requestURLString parameters:prams constructingBodyWithBlock:block success:sBlock failure:fBlock];
        } else {
            dataTask = [self.sessionManager POST:command.requestURLString parameters:prams success:sBlock failure:fBlock];
        }
    }
    
    [RequestLogger logRequestWithCommand:command task:dataTask];
    
    return dataTask;
}


#pragma mark - Helper
//公共参数
- (NSDictionary *)commonParameters {
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    @"os":@"ios",@"os_ver":[infoDictionary objectForKey:@"CFBundleShortVersionString"]
    return @{};
    
}

@end
