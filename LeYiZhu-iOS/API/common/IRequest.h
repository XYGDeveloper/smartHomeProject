//
//  IRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "LYZAPI.h"

@interface AbstractRequest: NSObject
- (instancetype) init:(NSString *)token;
@property (nonatomic, readwrite, copy) NSString *accessToken;
@property (nonatomic, strong, readwrite) Class responseClazz;
@property (nonatomic, strong, readwrite) NSString *url;
@property (nonatomic, retain) NSMutableDictionary *headers;
@property (nonatomic, retain) NSMutableDictionary *queryParameters;
@property (nonatomic, retain) NSMutableDictionary *pathParameters;

//追加请求头
@property (nonatomic, strong) NSDictionary *appendHeadDic;
@property (nonatomic, copy) NSString *headPlatform;
@property (nonatomic, copy) NSString *headTarget;
@property (nonatomic, copy) NSString *headMethod;

- (NSString *) getToken;
- (Class) getResponseClazz;
- (NSString *) getUrl;
- (NSString *) getApiUrl;
- (NSMutableDictionary *) getHeaders;
- (NSMutableDictionary *) getQueryParameters;
- (NSMutableDictionary *) getPathParameters;
- (NSString*)expandPath:(NSString*)path withURIVariablesArray:(NSArray*)URIVariables;
- (NSString*)expandPath:(NSString*)path withURIVariableDict:(NSDictionary*)URIVariables;
@end
