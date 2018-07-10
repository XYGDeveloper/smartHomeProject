//
//  UserRegisterRequest.h
//  NexPack
//
//  Created by levo on 15/9/16.
//  Copyright (c) 2015年 noa-labs. All rights reserved.
//

#import "IRequest.h"

@interface UserRegisterRequest : AbstractRequest

@property (nonatomic, readwrite, copy) NSString * phone;

@property (nonatomic,readwrite , copy) NSString * captcha;//验证码

@property (nonatomic, readwrite, copy) NSString * password;

@property(nonatomic, readwrite, copy) NSString * versioncode;

@property(nonatomic, readwrite, copy) NSString * devicenum;

@property (nonatomic,readwrite , copy) NSString * fromtype;// 1.android  2.ios



@end
