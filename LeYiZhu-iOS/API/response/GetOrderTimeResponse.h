//
//  GetOrderTimeResponse.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/13.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "AbstractResponse.h"
#import "APIOrderTime.h"

@interface GetOrderTimeResponse : AbstractResponse

@property(nonatomic, readonly, strong) APIOrderTime *baseOrderTime;

@end
