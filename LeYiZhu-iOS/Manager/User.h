//
//  User.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/25.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//


#import "BaseObject.h"
@class UserInfo;
@interface User : BaseObject

@property (nonatomic,copy) NSString * appUserID;

@property (nonatomic,copy) NSString * phone;

@property (nonatomic, copy) NSString * nickName;

@property (nonatomic, copy) NSString *facePath;

@property (nonatomic,copy) NSString * wechatLoginID;

@property (nonatomic, copy) NSString *weiboLoginID;

@property (nonatomic, copy) NSString * qqLoginID;

@property (nonatomic, strong) NSNumber *status;

@property (nonatomic, copy) NSString *token;

+(instancetype)initWithUserInfo:(UserInfo *)userInfo;

@end
