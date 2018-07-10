//
//  ProblemModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "ProblemModel.h"

@implementation ProblemModel

+(NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
             @"problemID":@"problemID",
             @"title":@"title",
             @"reply":@"reply"
             };
}





@end
