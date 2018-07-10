//
//  WeChatOrderModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "WeChatOrderModel.h"

@implementation WeChatOrderModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"orderNo":@"orderNo",
             @"orderType":@"orderType",
             @"appid":@"appid",
             @"partnerid":@"partnerid",
             @"prepayid":@"prepayid",
             @"packageStr":@"packageStr",
             @"noncestr":@"noncestr",
             @"timestamp":@"timestamp",
             @"sign":@"sign",
             };
}

@end
