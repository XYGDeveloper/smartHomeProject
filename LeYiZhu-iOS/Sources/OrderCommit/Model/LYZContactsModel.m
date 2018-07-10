//
//  LYZContactsModel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/10.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZContactsModel.h"

@implementation LYZContactsModel

-(instancetype)init{
    self = [super init];
    if (self) {
        self.isSelect = NO;
    }
    return self;
}

+(NSString *)resetPaperworkType:(NSNumber *)paperworkType{
    NSString * type = nil;
    switch (paperworkType.intValue) {
        case 1:
            type = @"二代身份证";
            break;
        case 2:
            type = @"港澳通行证";
            break;
        case 3:
            type = @"台湾通行证";
            break;
        case 4:
            type = @"护照";
            break;
        default:
            break;
    }
    return type;
}


@end
