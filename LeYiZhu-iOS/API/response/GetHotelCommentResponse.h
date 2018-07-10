//
//  GetHotelCommentResponse.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "AbstractResponse.h"
#import "BaseCommentModel.h"

@interface GetHotelCommentResponse : AbstractResponse

@property(nonatomic, readonly, strong)BaseCommentModel * baseComment;

@end
