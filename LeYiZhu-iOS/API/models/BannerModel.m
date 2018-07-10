//
//  BannerModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/14.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"bannerID":@"bannerID",
             @"type":@"type",
             @"imgPath":@"imgPath",
             @"content":@"content",
             @"objectID":@"objectID"
             };
}


@end
