//
//  CreateWeChatOrderResponse.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "CreateWeChatOrderResponse.h"

@implementation CreateWeChatOrderResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"weChatOrder":@"data"
             };
}

//+(NSValueTransformer *)weChatOrderJSONTransformer
//{
//    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[WeChatOrderModel class]];
//}

@end
