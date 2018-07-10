//
//  OrderDetailsModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "OrderDetailsModel.h"
#import "CheckInsModel.h"
#import "userRoomPwdsModel.h"

@implementation OrderDetailsModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"orderID":@"orderID",
             @"orderNO":@"orderNO",
             @"orderType":@"orderType",
             @"status":@"status",
             @"payTime":@"payTime",
             @"phone":@"phone",
             @"liveDays":@"liveDays",
             @"payNum":@"payNum",
             @"deductible":@"deductible",
             @"sum":@"sum",
             @"deposit":@"deposit",
             @"actualPayment":@"actualPayment",
             @"createTime":@"createTime",
             @"checkinTime":@"checkinTime",
             @"checkoutTime":@"checkoutTime",
             @"paperworkTime":@"paperworkTime",
             @"outTime":@"outTime",
             @"hotelName":@"hotelName",
             @"checkTime":@"checkTime",
             @"address":@"address",
             @"hotelRoomID":@"hotelRoomID",
             @"roomType":@"roomType",
             @"roomSize":@"roomSize",
             @"wifiType":@"wifiType",
             @"bedType":@"bedType",
             @"roomIntroduction":@"roomIntroduction",
             @"hotelID":@"hotelID",
             @"hotelName":@"hotelName",
             @"address":@"address",
             @"longitude":@"longitude",
             @"latitude":@"latitude",
             @"invoicesType":@"invoicesType",
             @"invoiceDetails":@"invoiceDetails",
             @"invoiceLookup":@"invoiceLookup",
             @"invoicesAddress":@"invoicesAddress",
             @"recipient":@"recipient",
             @"postage":@"postage",
             @"mailType":@"mailType",
             @"checkIns":@"checkIns",
             @"userRoomPwds":@"userRoomPwds",
             @"cancelTime":@"cancelTime"
             };
}

+(NSValueTransformer *)checkInsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass: [CheckInsModel class]];
}

+(NSValueTransformer *)userRoomPwdsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass: [userRoomPwdsModel class]];
}


@end
