//
//  CitysModel.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/11/30.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "CitysModel.h"

@implementation CitysModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"city_id":@"city_id",
             @"city_name":@"city_name",
             @"city_code":@"city_bianma",
             @"province_id":@"province_id"
             };
}

@end
