//
//  UserRole.m
//  NexPack
//
//  Created by levo on 15/9/15.
//  Copyright (c) 2015年 noa-labs. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             
             @"appUserID":@"appUserID",
             @"phone":@"phone",
             @"wechatLoginID":@"wechatLoginID",
             @"weiboLoginID":@"weiboLoginID",
             @"qqLoginID":@"qqLoginID",
             @"nickName":@"nickName",
             @"facePath":@"facePath",
             @"token":@"token",
             @"status":@"status"
             };
}


@end
