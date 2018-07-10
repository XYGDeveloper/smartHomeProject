//
//  SearchOrderListModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "SearchOrderListModel.h"

@implementation SearchOrderListModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"orderNO":@"orderNO",
             @"status":@"status",
             @"liveDays":@"liveDays",
             @"actualPayment":@"actualPayment",
             @"checkTime":@"checkTime",
             @"outTime":@"outTime",
             @"hotelName":@"hotelName",
             @"roomType":@"roomType" ,
             @"roomImgPath":@"roomImgPath"
             };
}


@end
