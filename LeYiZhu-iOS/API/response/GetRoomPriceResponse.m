//
//  GetRoomPriceResponse.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetRoomPriceResponse.h"
#import "RoomPriceInfo.h"

@implementation GetRoomPriceResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"roomPriceInfo":@"data"
             };
}

+(NSValueTransformer *)roomPriceInfoJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[RoomPriceInfo class]];
}

@end
