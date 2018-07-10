//
//  SearchForHotelsRequest.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/1.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "SearchForHotelsRequest.h"
#import "SearchForHotelsResponse.h"

@implementation SearchForHotelsRequest

- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    
    [self.queryParameters setValue:self.fromtype forKey:@"fromtype"];
    [self.queryParameters setValue:self.versioncode forKey:@"versioncode"];
    [self.queryParameters setValue:self.devicenum forKey:@"devicenum"];
    [self.queryParameters setValue:self.city_id forKey:@"city_id"];
    [self.queryParameters setValue:self.minprice forKey:@"minprice"];
    [self.queryParameters setValue:self.maxprice forKey:@"maxprice"];
    [self.queryParameters setValue:self.type forKey:@"type"];
    [self.queryParameters setValue:self.longitude forKey:@"longitude"];
    [self.queryParameters setValue:self.latitude forKey:@"latitude"];
    [self.queryParameters setValue:self.limit forKey:@"limit"];
    [self.queryParameters setValue:self.pages forKey:@"pages"];
    [self.queryParameters setValue:self.city_name forKey:@"city_name"];

    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    
    return [SearchForHotelsResponse class];
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_SEARCH_HOTEL];
//}


@end
