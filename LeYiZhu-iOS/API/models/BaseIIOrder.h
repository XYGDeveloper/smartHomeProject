//
//  BaseIIOrder.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/1/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BaseIIOrder : MTLModel<MTLJSONSerializing>

@property (nonatomic ,readonly, strong) NSArray *orders;

@end
