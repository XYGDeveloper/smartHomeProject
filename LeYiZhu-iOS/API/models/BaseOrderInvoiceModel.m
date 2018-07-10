//
//  OrderInvoiceModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/1/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "BaseOrderInvoiceModel.h"

@implementation BaseOrderInvoiceModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"invoiceType":@"invoiceType",
             @"invoiceDetail":@"invoiceDetail",
             @"lookup":@"lookup",
             @"taxNumber":@"taxNumber",
             @"recipient":@"recipient",
             @"phone":@"phone",
             @"address":@"address",
             @"mailType":@"mailType",
             @"email":@"email",
             @"invoiceremark":@"invoiceremark"
             };
}


@end
