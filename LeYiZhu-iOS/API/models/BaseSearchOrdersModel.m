//
//  BaseSearchOrdersModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "BaseSearchOrdersModel.h"
#import "SearchOrderListModel.h"

@implementation BaseSearchOrdersModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"orders":@"orders"
             };
}

+ (NSValueTransformer *)ordersJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[SearchOrderListModel class]];
}

@end
