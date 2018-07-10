//
//  GetPointsRecordResponse.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetPointsRecordResponse.h"

@implementation GetPointsRecordResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"pointRecord":@"data"
             };
}

+(NSValueTransformer *)pointRecordJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BasePointRecordModel class]];
}

@end
