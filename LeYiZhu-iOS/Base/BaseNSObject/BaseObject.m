//
//  BaseObject.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/25.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "BaseObject.h"
#import <objc/runtime.h>

@implementation BaseObject

//序列化
-(void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int ivarCount = 0;
    Ivar *ivars = class_copyIvarList([self class], &ivarCount);
    for (unsigned int i = 0; i < ivarCount; i++) {
        const char *ivar_name = ivar_getName(ivars[i]);
        NSString *key = [NSString stringWithCString:ivar_name encoding:NSUTF8StringEncoding];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
}

//反序列化
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        unsigned int ivarCount = 0;
        Ivar *ivars = class_copyIvarList([self class], &ivarCount);
        for (unsigned int i = 0; i < ivarCount; i++) {
            const char *ivar_name = ivar_getName(ivars[i]);
            NSString *key = [NSString stringWithCString:ivar_name encoding:NSUTF8StringEncoding];
            [self setValue:[coder decodeObjectForKey:key] forKey:key];
        }
    }
    return self;
}


@end
