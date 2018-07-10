//
//  CountMoneyResponse.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "CountMoneyResponse.h"

@implementation CountMoneyResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"countMoney":@"data"
             };
}

+ (NSValueTransformer *)countMoneyJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CountMoneyModel class]];
}



@end
