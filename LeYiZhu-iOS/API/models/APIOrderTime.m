//
//  APIOrderTime.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/14.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "APIOrderTime.h"

@implementation APIOrderTime

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"status":@"status",
             @"createTime":@"createTime",
             @"payTime":@"payTime",
             @"paperworkTime":@"paperworkTime",
             @"checkinTime":@"checkinTime",
             @"checkoutTime":@"checkoutTime",
             @"cancelTime":@"cancelTime",
             @"refundTime":@"refundTime",
             @"orderNO":@"orderNO"
             };
}

@end
