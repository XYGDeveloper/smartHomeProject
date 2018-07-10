//
//  CountRefillLiveMoneyRequest.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "IRequest.h"

@interface CountRefillLiveMoneyRequest : AbstractRequest

@property (nonatomic, copy) NSArray *childOrderIds;
@property (nonatomic, copy) NSString *coupondetatilid;



@end
