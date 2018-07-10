//
//  User.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/25.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "User.h"

@implementation User

+(instancetype)initWithUserInfo:(UserInfo *)userInfo{
    User *user= [[User alloc] init];
    user.appUserID = userInfo.appUserID;
    user.nickName = userInfo.nickName;
    user.facePath = userInfo.facePath;
    user.phone = userInfo.phone;
    user.qqLoginID = userInfo.qqLoginID;
    user.weiboLoginID = userInfo.weiboLoginID;
    user.wechatLoginID = userInfo.wechatLoginID;
    user.status = userInfo.status;
    user.token = userInfo.token;
    return user;
}

@end
