//
//  HotelCommentsModel.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "LYZCommentImage.h"
@interface HotelCommentsModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, readonly, strong) NSNumber *commentType;

@property(nonatomic, readonly, copy) NSString *nikeName;

@property(nonatomic, readonly, copy) NSString *satisfaction;
@property(nonatomic, readonly, copy) NSString * commentTime;

@property(nonatomic, readonly, copy)NSString * content;

@property(nonatomic, readonly, copy) NSString *facePath;

@property(nonatomic, readonly, copy) NSString *commentId;

@property(nonatomic, readonly, strong) NSNumber *isReply;

@property(nonatomic, readonly, copy) NSString *reply;

@property(nonatomic, readonly, strong) NSNumber *likeCount;

@property(nonatomic, readonly, strong) NSNumber *viewingCount;

@property(nonatomic, readonly, copy) NSString *isLike;

@property(nonatomic, readonly, copy) NSString *roomType;

@property(nonatomic, strong) NSArray *images;

@end
