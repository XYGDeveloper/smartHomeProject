//
//  FavoriteModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/9.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "FavoriteModel.h"

@implementation FavoriteModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"favoriteID":@"favoriteID",
             @"appUserID":@"appUserID",
             @"hotelID":@"hotelID",
             @"imgPath":@"imgPath",
             @"hotelName":@"hotelName",
             @"address":@"address",
             @"lowestPrice":@"lowestPrice",
             @"comentSum":@"comentSum"
             };
}


@end
