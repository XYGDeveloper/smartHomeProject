//
//  BaseProblemListModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "BaseProblemListModel.h"
#import "ProblemModel.h"

@implementation BaseProblemListModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"problems":@"problems"
             };
}

+ (NSValueTransformer *)problemsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[ProblemModel class]];
}

@end
