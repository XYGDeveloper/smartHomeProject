
//
//  GetHotelDetailRequest.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "GetHotelDetailRequest.h"
#import "GetHotelDetailResponse.h"

@implementation GetHotelDetailRequest

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
    [self.queryParameters setValue:self.hotelID forKey:@"hotelID"];
    [self.queryParameters setValue:self.appUserID forKey:@"appUserID"];
    [self.queryParameters setValue:self.checkInTime forKey:@"checkInTime"];
    [self.queryParameters setValue:self.checkOutTime forKey:@"checkOutTime"];
    
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    
    return [GetHotelDetailResponse class];
}



@end
