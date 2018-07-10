//
//  GetHotelRoomTypeListRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetHotelRoomTypeListRequest.h"
#import "GetHotelRoomTypeListResponse.h"

@implementation GetHotelRoomTypeListRequest

- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    [self.queryParameters setValue:self.fromtype forKey:@"fromtype"];
    [self.queryParameters setValue:self.versioncode forKey:@"versioncode"];
    [self.queryParameters setValue:self.devicenum forKey:@"devicenum"];
    [self.queryParameters setValue:self.hotelID forKey:@"hotelID"];
    [self.queryParameters setValue:self.checkInDate forKey:@"checkInDate"];
    [self.queryParameters setValue:self.checkOutDate forKey:@"checkOutDate"];
    
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [GetHotelRoomTypeListResponse class];
}




@end
