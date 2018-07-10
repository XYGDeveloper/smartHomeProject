//
//  MyProblemModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/17.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyProblemModel : NSObject

@property (nonatomic, assign) NSNumber *problemID;

@property (nonatomic, copy) NSString *reply;


- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;




@end
