//
//  GetUnpaidOrderResponse.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/5/8.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetUnpaidOrderResponse.h"

@implementation GetUnpaidOrderResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"order":@"data"
             };
}

+(NSValueTransformer *)orderJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[createOrderModel class]];
}

@end
