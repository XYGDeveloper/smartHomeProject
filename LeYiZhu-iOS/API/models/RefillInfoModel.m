//
//  RefillInfoModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "RefillInfoModel.h"
#import "OrderPreFillModel.h"

@implementation RefillInfoModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"checkInDate":@"checkInDate",
             @"checkOutDate":@"checkOutDate",
             @"continueDate":@"continueDate",
             @"roomNum":@"roomNum",
             @"liveUserName":@"liveUserName",
             @"liveUserPhone":@"liveUserPhone",
             @"isSelect":@"isSelect",
             @"childOrderId":@"childOrderId"
             };
}

@end
