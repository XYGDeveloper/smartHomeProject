//
//  TagModel.h
//  LeYiZhu-iOS
//
//  Created by xyg on 2018/1/20.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TagModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *id;

@property (nonatomic, readonly, strong) NSNumber *name;

@property (nonatomic, readonly, strong) NSNumber *count;

@end
