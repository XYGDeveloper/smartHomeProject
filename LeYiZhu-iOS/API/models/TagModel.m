//
//  TagModel.m
//  LeYiZhu-iOS
//
//  Created by xyg on 2018/1/20.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import "TagModel.h"

@implementation TagModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"id":@"id",
             @"name":@"name",
             @"count":@"count"
             };
}

@end
