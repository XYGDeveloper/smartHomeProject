//
//  BaseCommentTagModel.h
//  LeYiZhu-iOS
//
//  Created by xyg on 2018/1/20.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BaseCommentTagModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong, readonly) NSArray *tags;

@end
