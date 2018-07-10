//
//  AlipayOrderInfoResponse.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "AlipayOrderInfoResponse.h"

@implementation AlipayOrderInfoResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"alipayOrder":@"data"
             };
}

//+ (NSValueTransformer *)alipayOrderJSONTransformer {
//    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AlipayOrderModel class]];
//}

@end
