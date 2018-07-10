//
//  CountRefillLiveMoneyModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "CountRefillLiveMoneyModel.h"
#import "RenewRoomInfoModel.h"

@implementation CountRefillLiveMoneyModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"deductible":@"deductible",
             @"stayMoneySum":@"stayMoneySum",
             @"depositSum":@"depositSum",
             @"actualPayment":@"actualPayment",
             @"childOrderInfoJar":@"childOrderInfoJar",
             @"coupondetatilid":@"coupondetatilid",
             @"coupontype":@"coupontype",
             @"coupondenominat":@"coupondenominat",
             @"coupondiscount":@"coupondiscount",
             @"totalDiscount":@"totalDiscount"
             };
}
+(NSValueTransformer *)childOrderInfoJarJSONTransformer{
    
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[RenewRoomInfoModel class]];
}


@end
