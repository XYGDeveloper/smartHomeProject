//
//  MyContactsModel.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/12.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "MyContactsModel.h"

@implementation MyContactsModel

-(void)resetPaperworkType:(NSInteger )paperworkType{
    switch (paperworkType) {
        case IndentifierType:
            self.paperworkType = @"二代身份证";
            break;
        case hkPassportType:
            self.paperworkType = @"港澳通行证";
            break;
        case twPassportType:
            self.paperworkType = @"台湾通行证";
            break;
        case passportType:
            self.paperworkType = @"护照";
            break;
        default:
            break;
    }
    
}

@end
