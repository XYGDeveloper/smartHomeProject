//
//  SearchForKeywordsRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "SearchForKeywordsRequest.h"
#import "SearchForKeywordsResponse.h"

@implementation SearchForKeywordsRequest

- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    [self.queryParameters setValue:self.fromtype forKey:@"fromtype"];
    [self.queryParameters setValue:self.versioncode forKey:@"versioncode"];
    [self.queryParameters setValue:self.devicenum forKey:@"devicenum"];
    [self.queryParameters setValue:self.longitude forKey:@"longitude"];
    [self.queryParameters setValue:self.latitude forKey:@"latitude"];
    [self.queryParameters setValue:self.keywords forKey:@"keywords"];
    [self.queryParameters setValue:self.limit forKey:@"limit"];
    [self.queryParameters setValue:self.pages forKey:@"pages"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [SearchForKeywordsResponse class];
}




@end
