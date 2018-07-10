//
//  BaseCommentModel.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BaseCommentModel : MTLModel<MTLJSONSerializing>

@property(nonatomic ,readonly, strong) NSArray * comments;

@end
