//
//  BaseBannerListModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "BaseBannerListModel.h"
#import "BannersModel.h"
#import "RecommendsModel.h"
#import "ActivitysModel.h"

@implementation BaseBannerListModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"banners":@"banners",
             @"recommends":@"recommends",
             @"activitys":@"activitys",
             @"activityurl":@"activityurl"  
             };
}

+(NSValueTransformer *)bannersJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[BannersModel class]];
}


+(NSValueTransformer *)recommendsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[RecommendsModel class]];
}

+(NSValueTransformer *)activitysJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[ActivitysModel class]];
}



@end
