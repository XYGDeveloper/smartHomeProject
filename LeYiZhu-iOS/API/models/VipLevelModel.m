//
//  VipLevelModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "VipLevelModel.h"

@implementation VipLevelModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"code":@"code",
             @"name":@"name",
             @"discountrule":@"discountrule",
             @"pointsrule":@"pointsrule",
             @"checkouttimerule":@"checkouttimerule",
             @"imgUrl":@"imgurl",
             @"h5Url":@"url",
             @"exp":@"exp"
             };
}


@end
