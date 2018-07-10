//
//  CabinetNormsModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/29.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "CabinetNormsModel.h"

@implementation CabinetNormsModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"norm":@"norm",
             @"norminfo":@"norminfo",
             @"ishavecloselat":@"ishavecloselat"
             };
}

@end
