//
//  SearchHotelOrCityRequest.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/14.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "SearchHotelOrCityRequest.h"
#import "SearchHotelOrCityResponse.h"

@implementation SearchHotelOrCityRequest

- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    
    [self.queryParameters setValue:self.fromtype forKey:@"fromtype"];
    [self.queryParameters setValue:self.versioncode forKey:@"versioncode"];
    [self.queryParameters setValue:self.devicenum forKey:@"devicenum"];
    [self.queryParameters setValue:self.keywords forKey:@"keywords"];
    [self.queryParameters setValue:self.longitude forKey:@"longitude"];
    [self.queryParameters setValue:self.latitude forKey:@"latitude"];
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
    
    return [SearchHotelOrCityResponse class];
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_SEARCH_HOTELORCITY];
//}


@end
