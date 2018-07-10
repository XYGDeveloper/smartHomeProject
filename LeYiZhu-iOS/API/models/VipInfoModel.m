//
//  VipInfoModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "VipInfoModel.h"

@implementation VipInfoModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"vipname":@"vipname",
             @"discountrule":@"discountrule",
             @"pointsrule":@"pointsrule",
             @"checkouttimerule":@"checkouttimerule",
             @"exp":@"exp",
             @"vipcode":@"vipcode"
            };
}


@end
