//
//  GetValidRoomAmountRequest.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/25.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "GetValidRoomAmountRequest.h"
#import "GetValidRoomAmountResponse.h"

@implementation GetValidRoomAmountRequest

- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    
    [self.queryParameters setValue:self.fromtype forKey:@"fromtype"];
    [self.queryParameters setValue:self.versioncode forKey:@"versioncode"];
    [self.queryParameters setValue:self.devicenum forKey:@"devicenum"];
    [self.queryParameters setValue:self.checkInDate forKey:@"checkInDate"];
    [self.queryParameters setValue:self.checkOutDate forKey:@"checkOutDate"];
    [self.queryParameters setValue:self.roomTypeID forKey:@"roomTypeID"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [GetValidRoomAmountResponse class];
}




@end
