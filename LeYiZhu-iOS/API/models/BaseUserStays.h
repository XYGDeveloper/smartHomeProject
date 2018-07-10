//
//  BaseUserStays.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/22.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BaseUserStays : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, strong) NSArray *userStays;

@end
