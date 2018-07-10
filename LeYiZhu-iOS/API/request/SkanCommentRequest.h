//
//  SkanCommentRequest.h
//  LeYiZhu-iOS
//
//  Created by xyg on 2018/1/20.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import "IRequest.h"

@interface SkanCommentRequest : AbstractRequest

@property (nonatomic, copy) NSString *versioncode;

@property (nonatomic, copy) NSString *devicenum;

@property(nonatomic, copy) NSString *fromtype;

@property (nonatomic, copy) NSString *commentId;

@end
