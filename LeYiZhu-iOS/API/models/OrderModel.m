//
//  OrderModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/1/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"orderID":@"orderID",
             @"orderNO":@"orderNO",
             @"orderType":@"orderType",
             @"hostStatus":@"hostStatus",
             @"childStatus":@"childStatus",
             @"payNum":@"payNum",
             @"stayMoneySum":@"stayMoneySum",
             @"depositSum":@"depositSum",
             @"actualPayment":@"actualPayment",
             @"deductible":@"deductible",
             @"phone":@"phone",
             @"checkInDate":@"checkInDate",
             @"checkOutDate":@"checkOutDate",
             @"createTime":@"createTime",
             @"coupondetatilid":@"coupondetatilid",
             @"coupontype":@"coupontype",
             @"coupondenominat":@"coupondenominat",
             @"coupondiscount":@"coupondiscount",
             @"returnAmount":@"returnAmount",
             @"customerServiceDiscount":@"customerServiceDiscount",
             @"paid":@"paid",
             @"deduction":@"deduction",
             @"isCancel":@"isCancel",
             @"totalDiscount":@"totalDiscount"
             };
}

@end
