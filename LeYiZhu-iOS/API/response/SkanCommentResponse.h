//
//  SkanCommentResponse.h
//  LeYiZhu-iOS
//
//  Created by xyg on 2018/1/20.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import "AbstractResponse.h"
@class LYZcommentDetailModel;
@interface SkanCommentResponse : AbstractResponse

@property (nonatomic, readonly, copy) LYZcommentDetailModel *detail;

@end
