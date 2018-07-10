//
//  BaseSearchForKeywordsModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "BaseSearchForKeywordsModel.h"
#import "SearchLoadHotelModel.h"

@implementation BaseSearchForKeywordsModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"hotels":@"hotels"
             };
}

+(NSValueTransformer *)hotelsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[SearchLoadHotelModel class]];
}

@end
