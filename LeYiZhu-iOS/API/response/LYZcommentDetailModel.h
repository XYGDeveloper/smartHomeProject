//
//  LYZcommentDetailModel.h
//  LeYiZhu-iOS
//
//  Created by L on 2018/1/23.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface LYZcommentDetailModel : MTLModel<MTLJSONSerializing>

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
