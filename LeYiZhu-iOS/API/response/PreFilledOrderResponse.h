//
//  PreFilledOrderResponse.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/11.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "AbstractResponse.h"
#import "OrderPreFillModel.h"

@interface PreFilledOrderResponse : AbstractResponse

@property (nonatomic, readonly, strong) OrderPreFillModel *prefillModel;

@end
