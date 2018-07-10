//
//  MyProblemModel.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/17.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "MyProblemModel.h"

@implementation MyProblemModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([value isKindOfClass:[NSNull class]]) {
        
        return;
    }
    
    [super setValue:value forKey:key];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        
        if (self = [super init]) {
            
            [self setValuesForKeysWithDictionary:dictionary];
        }
        
        return self;
        
    } else {
        
        return nil;
    }
}

@end
