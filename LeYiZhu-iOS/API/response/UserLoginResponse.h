//
//  UserLoginResponse.h
//  NexPack
//
//  Created by levo on 15/9/15.
//  Copyright (c) 2015年 noa-labs. All rights reserved.
//

#import "AbstractResponse.h"
#import "UserInfo.h"



@interface UserLoginResponse : AbstractResponse

@property (nonatomic,readonly,copy)UserInfo  * userInfo;

//@property (nonatomic,readonly,copy) NSString * token;
//
//@property (nonatomic,readonly,copy) NSString * email;
//
//@property (nonatomic,readonly,copy) NSNumber * gender;
//
//@property (nonatomic,readonly,copy) NSString * name;
//
//@property (nonatomic,readonly,copy) NSString * nationality;
//
//@property (nonatomic,readonly,copy) NSString * tokenTime;
//
//@property (nonatomic,readonly,copy) NSString * userUUID;


@end
