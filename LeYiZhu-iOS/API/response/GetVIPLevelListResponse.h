//
//  GetVIPLevelListResponse.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AbstractResponse.h"

@class BaseVipLevelModel;
@interface GetVIPLevelListResponse : AbstractResponse

@property (nonatomic, readonly, strong) BaseVipLevelModel *baseVipLevel;


@end
