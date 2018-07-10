//
//  createOrderModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/7.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "createOrderModel.h"

@implementation createOrderModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"orderNo":@"orderNO",
             @"orderType":@"orderType"
             };
}

@end
