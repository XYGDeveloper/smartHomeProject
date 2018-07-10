//
//  PointsModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "PointsModel.h"

@implementation PointsModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"time":@"time",
             @"incomevalue":@"incomevalue",
             @"type":@"type"
             };
}

@end
