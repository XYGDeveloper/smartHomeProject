//
//  EditInvoiceAddressResponse.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "EditInvoiceAddressResponse.h"


@implementation EditInvoiceAddressResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"editeInvoiceAddressResult":@"data"
             };
}

+(NSValueTransformer *)editeInvoiceAddressResultJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[EditInvoiceAddressResultModel class]];
}


@end
