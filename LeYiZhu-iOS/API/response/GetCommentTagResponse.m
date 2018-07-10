//
//  GetCommentTagResponse.m
//  LeYiZhu-iOS
//
//  Created by xyg on 2018/1/20.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import "GetCommentTagResponse.h"
#import "BaseCommentTagModel.h"
@implementation GetCommentTagResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"tags":@"data"
             };
}

+(NSValueTransformer *)tagsJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseCommentTagModel class]];
}
@end
