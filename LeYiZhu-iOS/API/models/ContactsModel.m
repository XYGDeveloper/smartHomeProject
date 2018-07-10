//
//  ContactsModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "ContactsModel.h"

@implementation ContactsModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"contactsID":@"contactsID",
             @"name":@"name",
             @"paperworkType":@"paperworkType",
             @"paperworkNum":@"paperworkNum",
             @"sex":@"sex",
             @"phone":@"phone"
             };
}

@end
