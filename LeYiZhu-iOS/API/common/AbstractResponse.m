//
//  AbstractResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-19.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "AbstractResponse.h"

@implementation AbstractResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return  @{
             @"returncode":@"returncode",
             @"msg":@"msg",
             };
}

@end
