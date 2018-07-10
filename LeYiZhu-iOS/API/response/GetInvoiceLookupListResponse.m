//
//  GetInvoiceLookupListResponse.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetInvoiceLookupListResponse.h"

@implementation GetInvoiceLookupListResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"baseLookup":@"data"
             };
}

+(NSValueTransformer *)baseLookupJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BaseLookupListModel class]];
}


@end
