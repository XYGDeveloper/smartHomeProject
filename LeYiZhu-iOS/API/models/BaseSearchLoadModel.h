//
//  BaseSearchLoadModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BaseSearchLoadModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, strong) NSArray *hotels;

@property (nonatomic, readonly, strong) NSArray *citys;

@end
