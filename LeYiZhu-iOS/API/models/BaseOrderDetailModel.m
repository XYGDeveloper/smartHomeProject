//
//  BaseOrderDetailModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "BaseOrderDetailModel.h"

@implementation BaseOrderDetailModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"hotelJson":@"hotelJson",
             @"orderJson":@"orderJson",
             @"invoiceJson":@"invoiceJson",
             @"childOrderInfoJar":@"childOrderInfoJar"
             };
}

+(NSValueTransformer *)hotelJsonJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OrderHotelModel class]];
}


+(NSValueTransformer *)orderJsonJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OrderModel class]];
}

+(NSValueTransformer *)invoiceJsonJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseOrderInvoiceModel class]];
}

+(NSValueTransformer *)childOrderInfoJarJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[OrderCheckInsModel class]];
}




@end
