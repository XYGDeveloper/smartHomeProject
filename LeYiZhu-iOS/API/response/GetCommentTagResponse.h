//
//  GetCommentTagResponse.h
//  LeYiZhu-iOS
//
//  Created by xyg on 2018/1/20.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import "AbstractResponse.h"
#import "BaseCommentTagModel.h"
@interface GetCommentTagResponse : AbstractResponse
@property (nonatomic, readonly, strong) BaseCommentTagModel *tags;

@end
