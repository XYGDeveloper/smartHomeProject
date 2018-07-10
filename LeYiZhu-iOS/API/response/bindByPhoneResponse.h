//
//  bindByPhoneResponse.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/29.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "AbstractResponse.h"
@class UserInfo;

@interface bindByPhoneResponse : AbstractResponse

@property (nonatomic, readonly, strong)  UserInfo *userInfo;

@end
