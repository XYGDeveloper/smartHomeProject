//
//  AddCommentRequest.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/1/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "AddCommentRequest.h"
#import "AddCommentResponse.h"

@implementation AddCommentRequest

- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    
    [self.queryParameters setValue:self.fromtype forKey:@"fromtype"];
    [self.queryParameters setValue:self.versioncode forKey:@"versioncode"];
    [self.queryParameters setValue:self.devicenum forKey:@"devicenum"];
    
    [self.queryParameters setValue:self.orderNO forKey:@"orderNO"];
    [self.queryParameters setValue:self.appUserID  forKey:@"appUserID"];
    [self.queryParameters setValue:self.hotelID forKey:@"hotelID"];
     [self.queryParameters setValue:self.childOrderId forKey:@"childOrderId"];
    [self.queryParameters setValue:self.comments forKey:@"comments"];
    [self.queryParameters setValue:self.satisFaction forKey:@"satisFaction"];
    [self.queryParameters setValue:self.images forKey:@"images"];

    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [AddCommentResponse class];
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_ADD_COMMENT];
//}


@end
