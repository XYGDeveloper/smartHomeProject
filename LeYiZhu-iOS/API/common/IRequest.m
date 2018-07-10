//
//  IRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "NSString+RegexpReplace.h"
#define PATTERN  @"(\\{.+?\\})"

@implementation AbstractRequest

- (instancetype) init:(NSString *)token {
    self = [super init];
    self.headers = [NSMutableDictionary dictionary];
    self.queryParameters = [NSMutableDictionary dictionary];
    self.pathParameters = [NSMutableDictionary dictionary];
    self.accessToken = token;
    self.url = self.getApiUrl;
    self.responseClazz = self.getResponseClazz;
    return self;
}

- (NSString *) getToken
{
    return  self.accessToken;
}

- (Class) getResponseClazz
{
    return self.responseClazz;
}
- (NSString *) getApiUrl
{
   return LYZ_PREFIX_Normal;
}

- (void) setHeader:(NSString *) key value:(NSString *) value{
    [self.headers setValue:value forKey:key];
}

- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    return self.queryParameters ;
}
- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

-(NSDictionary *)appendHeadDic{
    
    return @{PLATFORM:self.headPlatform?:@"",METHOD:self.headMethod?:@"",TARGET:self.headTarget?:@""};
}


- (NSString *) getUrl
{
    NSString *apiUrl = [self getApiUrl];
    NSString *url = [self expandPath:apiUrl withURIVariableDict:self.getPathParameters];
    NSLog(@"pppp====%@",url);
    return url;
}

- (NSString*)expandPath:(NSString*)path withURIVariablesArray:(NSArray*)URIVariables {
    
    NSError *error = NULL;
    // Match all {...} in the path
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:PATTERN
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (nil != error) {
//        LYLog(@"Regular expression failed with reason:%@", error);
        
        // TODO handle regular expresssion errors
    }
    
    NSString *expandedPath =
    [path stringByReplacingMatches:regex
                           options:0
                             range:NSMakeRange(0, [path length])
           withTransformationBlock:^NSString *(NSString *stringToReplace, NSUInteger index, BOOL *stop) {
               // Get the replacement string from collected var args
               if (index >= [URIVariables count]) {
                   LYLog(@"Warning, variable:%@ not found in var args, will not expand", stringToReplace);
                   return stringToReplace;
               }
               
               // URL encode the replacement string
               return  AFPercentEscapedQueryStringPairMemberFromStringWithEncoding([URIVariables objectAtIndex:index],
                                                                                   NSUTF8StringEncoding);
           }];
    
    //NSLog(@"Path:%@ Var args:%@ Expanded:%@", path, replacements, expandedPath);
    return expandedPath;  
}
// Expand a path using a dictonary of replacement variables
- (NSString*)expandPath:(NSString*)path withURIVariableDict:(NSDictionary*)URIVariables {
    
    NSError *error = NULL;
    // Match all {...} in the path
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:PATTERN
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (nil != error) {
        LYLog(@"Regular expression failed with reason:%@", error);
        
        // TODO handle regular expresssion errors
    }
    
    NSString *expandedPath =
    [path stringByReplacingMatches:regex
                           options:0 range:NSMakeRange(0, [path length])
           withTransformationBlock:^NSString *(NSString *stringToReplace, NSUInteger index, BOOL *stop) {
               //NSLog(@"Find replacement for:%@", stringToReplace);
               
               // Get the replacement string from the dictonary
               NSString *replacement = [URIVariables valueForKey:[stringToReplace substringWithRange:NSMakeRange(1, stringToReplace.length - 2)]];
               if (nil == replacement) {
                   LYLog(@"Warning, variable:%@ not found in dictonary, will not expand", stringToReplace);
                   return stringToReplace;
               }
               
               // URL encode the replacement string
               return AFPercentEscapedQueryStringPairMemberFromStringWithEncoding(replacement, NSUTF8StringEncoding);
           }];
    
    //NSLog(@"Path:%@ Dict:%@ Expanded:%@", path, URIVariables, expandedPath);
    return expandedPath;
}

static NSString * AFPercentEscapedQueryStringPairMemberFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
    static NSString * const kAFCharactersToBeEscaped = @":/?&=;+!@#$()~";
    static NSString * const kAFCharactersToLeaveUnescaped = @"[].";
    
	return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, (__bridge CFStringRef)kAFCharactersToLeaveUnescaped, (__bridge CFStringRef)kAFCharactersToBeEscaped, CFStringConvertNSStringEncodingToEncoding(encoding));
}

@end
