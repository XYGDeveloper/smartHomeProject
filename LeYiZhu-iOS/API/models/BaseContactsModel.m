//
//  BaseContactsModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "BaseContactsModel.h"
#import "ContactsModel.h"

@implementation BaseContactsModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"appContacts":@"contacts"
             };
}

+ (NSValueTransformer *)appContactsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[ContactsModel class]];
}

@end
