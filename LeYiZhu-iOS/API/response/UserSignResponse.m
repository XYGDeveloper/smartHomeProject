//
//  UserSignResponse.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "UserSignResponse.h"

@implementation UserSignResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"result":@"data"
             };
}

@end
