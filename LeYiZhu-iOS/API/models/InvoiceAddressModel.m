//
//  InvoiceAddressModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "InvoiceAddressModel.h"

@implementation InvoiceAddressModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"invoiceAddressID":@"id",
             @"userId":@"userId",
             @"recipient":@"recipient",
             @"phone":@"phone",
             @"province":@"province",
             @"city":@"city",
             @"area":@"area",
             @"createTime":@"createTime",
             @"address":@"address",
             @"status":@"status",
             @"useAmount":@"useAmount"
             };
}

@end
