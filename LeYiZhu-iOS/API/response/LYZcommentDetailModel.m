//
//  LYZcommentDetailModel.m
//  LeYiZhu-iOS
//
//  Created by L on 2018/1/23.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import "LYZcommentDetailModel.h"
#import "LYZCommentImage.h"
@implementation LYZcommentDetailModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"commentType":@"commentType",
             @"nikeName":@"nikeName",
             @"satisfaction":@"satisfaction",
             @"commentTime":@"commentTime",
             @"content":@"content",
             @"facePath":@"facePath",
             @"commentId":@"commentId",
             @"isReply":@"isReply",
             @"likeCount":@"likeCount",
             @"viewingCount":@"viewingCount",
             @"isLike":@"isLike",
             @"images":@"images",
             @"roomType":@"roomType",
             @"reply":@"reply",
             };
}
+ (NSValueTransformer *)imagesJSONTransformer{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[LYZCommentImage class]];
}
@end
