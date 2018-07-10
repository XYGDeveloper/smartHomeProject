//
//  ActivitysModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "ActivitysModel.h"

@implementation ActivitysModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"activitysID":@"id",
             @"imgpath":@"imgpath",
             @"title":@"title",
             @"scope":@"scope",
             @"subtitle":@"subtitle",
              @"pubtime":@"pubtime",
             @"url":@"url"
             };
}


@end
