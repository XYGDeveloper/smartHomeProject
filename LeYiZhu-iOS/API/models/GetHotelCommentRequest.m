//
//  GetHotelCommentRequest.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "GetHotelCommentRequest.h"
#import "GetHotelCommentResponse.h"

@implementation GetHotelCommentRequest

- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    [self.queryParameters setValue:self.fromtype forKey:@"fromtype"];
    [self.queryParameters setValue:self.versioncode forKey:@"versioncode"];
    [self.queryParameters setValue:self.devicenum forKey:@"devicenum"];
    [self.queryParameters setValue:self.limit forKey:@"limit"];
    [self.queryParameters setValue:self.pages forKey:@"pages"];
    [self.queryParameters setValue:self.hotelID forKey:@"hotelID"];
    [self.queryParameters setValue:self.tagId forKey:@"tagId"];
    
    NSLog(@"%@",self.queryParameters);
    
    return self.queryParameters;
}
- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    
    return [GetHotelCommentResponse class];
}




@end
