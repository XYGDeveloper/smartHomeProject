//
//  RegisterCaptchaResponse.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/11/28.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "RegisterCaptchaResponse.h"
@implementation RegisterCaptchaResponse

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"captcha":@"data"
             };
}

@end
