//
//  GetContactsListResponse.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "GetContactsListResponse.h"

@implementation GetContactsListResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"baseContacts":@"data"
             };
}

+(NSValueTransformer *)baseContactsJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseContactsModel class]];
}

@end
