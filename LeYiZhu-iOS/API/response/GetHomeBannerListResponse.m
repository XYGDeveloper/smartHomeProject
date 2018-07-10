//
//  GetBannerListResponse.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetHomeBannerListResponse.h"

@implementation GetHomeBannerListResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"baseBannerList":@"data"
             };
}

+(NSValueTransformer *)baseBannerListJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseBannerListModel class]];
}


@end
