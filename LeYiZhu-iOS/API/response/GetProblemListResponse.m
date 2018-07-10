//
//  GetProblemListResponse.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "GetProblemListResponse.h"
#import "BaseProblemListModel.h"

@implementation GetProblemListResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"baseProblemList":@"data"
             };
}

+(NSValueTransformer *)baseProblemListJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseProblemListModel class]];
}

@end
