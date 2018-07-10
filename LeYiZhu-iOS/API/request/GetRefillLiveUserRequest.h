//
//  GetRefillLiveUserRequest.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "IRequest.h"

@interface GetRefillLiveUserRequest : AbstractRequest

@property (nonatomic, copy) NSString *versioncode;

@property (nonatomic, copy) NSString *devicenum;

@property (nonatomic, copy) NSString *fromtype;

@property (nonatomic, copy) NSString *orderNO;

@property (nonatomic, copy) NSString *appUserID;

@property (nonatomic, copy) NSString *orderType;

@end
