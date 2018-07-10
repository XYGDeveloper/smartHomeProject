//
//  CheckInsModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "CheckInsModel.h"

@implementation CheckInsModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"name":@"name",
             @"paperworkType":@"paperworkType",
             @"paperworkNum":@"paperworkNum",
             @"liveRrcordPhone":@"liveRrcordPhone"
             };
}

@end
