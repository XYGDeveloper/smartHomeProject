//
//  StayListResponse.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/22.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "AbstractResponse.h"
#import "BaseUserStays.h"

@interface StayListResponse : AbstractResponse

@property (nonatomic, readonly, strong) BaseUserStays *baseStays;

@end
