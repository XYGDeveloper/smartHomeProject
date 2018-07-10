//
//  SearchForOrdersResponse.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "SearchForOrdersResponse.h"
#import "SearchOrderListModel.h"

@implementation SearchForOrdersResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"orderlist":@"data"
             };
}

+(NSValueTransformer *)orderlistJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseSearchOrdersModel class]];
}

@end
