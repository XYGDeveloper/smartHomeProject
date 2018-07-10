//
//  GetHotelIntroResponse.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/5.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetHotelIntroResponse.h"

@implementation GetHotelIntroResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"hotelIntro":@"data"
             };
}

+(NSValueTransformer *)hotelIntroJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[HotelIntroModel class]];
}


@end
