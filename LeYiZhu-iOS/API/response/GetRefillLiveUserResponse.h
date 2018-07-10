//
//  GetRefillLiveUserResponse.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AbstractResponse.h"

@class BaseRefillInfoModel;
@interface GetRefillLiveUserResponse : AbstractResponse

@property (nonatomic, readonly, strong) BaseRefillInfoModel *baseRefillModel;

@end
