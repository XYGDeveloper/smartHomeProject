//
//  LookupModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LookupModel.h"

@implementation LookupModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"lookupID":@"id",
             @"userId":@"userId",
             @"type":@"type",
             @"lookUp":@"lookUp",
             @"taxNumber":@"taxNumber",
             @"createTime":@"createTime",
             @"status":@"status",
             @"useAmount":@"useAmount"
             };
}

@end
