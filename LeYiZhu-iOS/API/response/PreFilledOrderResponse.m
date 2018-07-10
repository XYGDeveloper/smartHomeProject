//
//  PreFilledOrderResponse.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/11.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "PreFilledOrderResponse.h"

@implementation PreFilledOrderResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"prefillModel":@"data"
             };
}

+(NSValueTransformer *) prefillModelJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OrderPreFillModel class]];
}

@end
