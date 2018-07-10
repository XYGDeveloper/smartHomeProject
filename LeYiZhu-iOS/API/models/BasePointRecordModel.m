//
//  BasePointRecordModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "BasePointRecordModel.h"
#import "PointsModel.h"


@implementation BasePointRecordModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"points":@"points"
             };
}

+(NSValueTransformer *)pointsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[PointsModel class]];
}

@end
