//
//  UserLoginRequest.h
//  NexPack
//
//  Created by levo on 15/9/15.
//  Copyright (c) 2015年 noa-labs. All rights reserved.
//

#import "IRequest.h"
#import "UserLoginResponse.h"


@interface UserLoginRequest : AbstractRequest

@property (nonatomic, readwrite, copy) NSString *phone;

@property (nonatomic,readwrite , copy) NSString * password;

@property (nonatomic, copy) NSString *versioncode;

@property (nonatomic, copy) NSString * devicenum;

@property (nonatomic, copy) NSString *fromtype;

@end
