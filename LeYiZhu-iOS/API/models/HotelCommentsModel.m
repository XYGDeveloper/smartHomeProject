//
//  HotelCommentsModel.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "HotelCommentsModel.h"
#import "LYZCommentImage.h"
@implementation HotelCommentsModel

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
