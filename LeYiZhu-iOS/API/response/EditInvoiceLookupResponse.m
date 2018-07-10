//
//  EditInvoiceLookupResponse.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "EditInvoiceLookupResponse.h"

@implementation EditInvoiceLookupResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"editTitleResult":@"data"
             };
}

+(NSValueTransformer *)editTitleResultJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[EditLookupResultModel class]];
}

@end
