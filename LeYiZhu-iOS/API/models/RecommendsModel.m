//
//  RecommendsModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "RecommendsModel.h"

@implementation RecommendsModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"recommendID":@"id",
             @"imgpath":@"imgpath",
             @"hotelid":@"hotelid",
             @"hotelname":@"hotelname",
             @"subtitle":@"subtitle",
             @"url":@"url"
             };
}

@end
