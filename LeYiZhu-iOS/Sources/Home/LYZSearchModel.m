//
//  LYZSearchModel.m
//  LeYiZhu-iOS
//
//  Created by xyg on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZSearchModel.h"

@implementation LYZSearchModel

- (void)setValue:(id)value forKey:(NSString *)key
{

    if ([key isEqualToString:@"id"]) {
        
        self.hid = value;
        
    }

}



@end
