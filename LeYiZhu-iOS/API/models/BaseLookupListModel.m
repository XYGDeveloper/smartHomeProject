//
//  BaseLookupListModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "BaseLookupListModel.h"
#import "LookupModel.h"

@implementation BaseLookupListModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"lookUpJarSize":@"lookUpJarSize",
             @"lookUpJar":@"lookUpJar"
             };
}

+(NSValueTransformer *)lookUpJarJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[LookupModel class]];
}


@end
