//
//  GetUnpaidOrderResponse.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/5/8.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AbstractResponse.h"
#import "createOrderModel.h"

@interface GetUnpaidOrderResponse : AbstractResponse

@property (nonatomic, readonly, copy) createOrderModel *order;

@end
