//
//  BasePointRecordModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BasePointRecordModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong, readonly) NSArray *points;

@end
