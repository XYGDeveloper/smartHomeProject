//
//  ApplyVipRequest.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "IRequest.h"

@interface ApplyVipRequest : AbstractRequest

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *idcard;

@property (nonatomic, copy)NSString *email;

@property (nonatomic,copy) NSString *invitecode;


@end
