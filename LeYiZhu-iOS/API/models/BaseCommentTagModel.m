//
//  BaseCommentTagModel.m
//  LeYiZhu-iOS
//
//  Created by xyg on 2018/1/20.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import "BaseCommentTagModel.h"
#import "TagModel.h"
@implementation BaseCommentTagModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"tags":@"tags"
             };
}

+(NSValueTransformer *)tagsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[TagModel class]];
}

@end
