//
//  CommitRefillLiveOrderResponse.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AbstractResponse.h"
#import "CreateRenewModel.h"

@interface CommitRefillLiveOrderResponse : AbstractResponse

@property (nonatomic, readonly, copy) CreateRenewModel *renewOrder;

@end
