//
//  UserLoginByMobileRequest.h
//  LeYiZhu-iOS
//
//  Created by L on 2017/3/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "IRequest.h"
#import "UseLoginBycache.h"
@interface UserLoginByMobileRequest : AbstractRequest

@property (nonatomic, readwrite, copy) NSString *phone;

@property (nonatomic,readwrite , copy) NSString * captcha;

@property (nonatomic, copy) NSString *versioncode;

@property (nonatomic, copy) NSString * devicenum;

@property (nonatomic, copy) NSString *fromtype;


@end
