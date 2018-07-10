//
//  AccessToken.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "AccessToken.h"

@implementation AccessToken

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
             @"accessToken":@"access_token",
             @"tokenType":@"token_type",
             @"expiresIn":@"expires_in",
             @"refreshToken":@"refresh_token",
             @"scope":@"scope"
             };
}
@end
