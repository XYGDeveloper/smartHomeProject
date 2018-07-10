//
//  UserResetPswRequest.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/11/30.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "IRequest.h"

@interface UserResetPswRequest : AbstractRequest

@property (nonatomic, readwrite, copy) NSString * phone;

@property (nonatomic,readwrite , copy) NSString * captcha;//验证码

@property (nonatomic, readwrite, copy) NSString * password;

@property(nonatomic, readwrite, copy) NSString * versioncode;

@property(nonatomic, readwrite, copy) NSString * devicenum;

@property (nonatomic,readwrite , copy) NSString * fromtype;// 1.android  2.ios

@end
