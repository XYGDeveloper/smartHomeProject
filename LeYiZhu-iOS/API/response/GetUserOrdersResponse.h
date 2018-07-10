//
//  GetUserOrdersResponse.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/1/21.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "AbstractResponse.h"
#import "BaseIIOrder.h"


@interface GetUserOrdersResponse : AbstractResponse

@property (nonatomic, readonly, strong) BaseIIOrder *baseiiOrder;

@end
