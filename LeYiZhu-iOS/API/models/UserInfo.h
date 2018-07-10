//
//  UserRole.h
//  NexPack
//
//  Created by levo on 15/9/15.
//  Copyright (c) 2015年 noa-labs. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UserInfo : MTLModel <MTLJSONSerializing>


@property (nonatomic,readonly,copy) NSString * appUserID;

@property (nonatomic,copy) NSString * phone;

@property (nonatomic, readonly, copy) NSString * nickName;

@property (nonatomic, readonly, copy) NSString *facePath;

@property (nonatomic,readonly,copy) NSString * wechatLoginID;

@property (nonatomic, readonly, copy) NSString *weiboLoginID;

@property (nonatomic, readonly, copy) NSString * qqLoginID;

@property (nonatomic, readonly, copy) NSString *token;

@property (nonatomic, readonly, strong) NSNumber *status;





@end
