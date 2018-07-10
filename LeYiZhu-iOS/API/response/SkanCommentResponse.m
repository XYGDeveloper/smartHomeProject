//
//  SkanCommentResponse.m
//  LeYiZhu-iOS
//
//  Created by xyg on 2018/1/20.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import "SkanCommentResponse.h"
#import "LYZcommentDetailModel.h"
@implementation SkanCommentResponse

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"detail":@"data"
             };
}

+(NSValueTransformer *)detailJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[LYZcommentDetailModel class]];
}

@end
