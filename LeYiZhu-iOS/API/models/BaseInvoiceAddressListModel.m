//
//  BaseInvoiceAddressListModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "BaseInvoiceAddressListModel.h"
#import "InvoiceAddressModel.h"


@implementation BaseInvoiceAddressListModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"addressJarSize":@"addressJarSize",
             @"addressJar":@"addressJar"
             };
}

+(NSValueTransformer *)addressJarJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[InvoiceAddressModel class]];
}


@end
