//
//  GetInvoiceAddressListResponse.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetInvoiceAddressListResponse.h"

@implementation GetInvoiceAddressListResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"baseInvoiceAddress":@"data"
             };
}

+(NSValueTransformer *)baseInvoiceAddressJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseInvoiceAddressListModel class]];
}


@end
