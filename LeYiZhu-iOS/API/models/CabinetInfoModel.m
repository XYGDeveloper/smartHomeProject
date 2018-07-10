//
//  CabinetInfoModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/29.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "CabinetInfoModel.h"
#import "CabinetNormsModel.h"

@implementation CabinetInfoModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"cabinetID":@"id",
             @"cabtype":@"cabtype",
             @"opentype":@"opentype",
             @"latticeid":@"latticeid",
             @"normjar":@"normjar"
             };
}

+(NSValueTransformer *)normjarJSONTransformer{
    
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CabinetNormsModel class]];
}



@end
