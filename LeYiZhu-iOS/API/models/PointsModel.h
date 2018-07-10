//
//  PointsModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface PointsModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *time;

@property (nonatomic, readonly, strong) NSNumber *incomevalue;

@property (nonatomic, readonly, strong) NSNumber *type;

@end
