//
//  BannersModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "BannersModel.h"

@implementation BannersModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"bannerID":@"id",
             @"imgpath":@"imgpath",
             @"subtitle":@"subtitle",
             @"url":@"url"
             };
}

@end
