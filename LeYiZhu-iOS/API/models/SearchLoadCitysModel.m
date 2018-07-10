//
//  SearchLoadCitysModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "SearchLoadCitysModel.h"

@implementation SearchLoadCitysModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"cityID":@"id",
             @"name":@"name",
             @"status":@"status"
             };
}


@end
