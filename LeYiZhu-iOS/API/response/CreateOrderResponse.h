//
//  CreateOrderResponse.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/7.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "AbstractResponse.h"
#import "createOrderModel.h"

@interface CreateOrderResponse : AbstractResponse

@property (nonatomic, readonly, copy) createOrderModel *order;

@end
