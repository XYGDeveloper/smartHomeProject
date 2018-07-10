//
//  RetreatRoomRequest.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/2/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "RetreatRoomRequest.h"
#import "RetreatRoomResponse.h"

@implementation RetreatRoomRequest

- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    
    [self.queryParameters setValue:self.fromtype forKey:@"fromtype"];
    [self.queryParameters setValue:self.versioncode forKey:@"versioncode"];
    [self.queryParameters setValue:self.devicenum forKey:@"devicenum"];
    [self.queryParameters setValue:self.appUserID forKey:@"appUserID"];
    [self.queryParameters setValue:self.roomID forKey:@"roomID"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [RetreatRoomResponse class];
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_RETREAT_ROOM];
//}

@end
