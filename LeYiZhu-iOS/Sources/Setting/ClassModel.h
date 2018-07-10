//
//  ClassModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>
#import "MyProblemModel.h"

@interface ClassModel : NSObject

@property (nonatomic, strong) NSString                  *num;

@property (nonatomic, strong) NSString *problem;

@property (nonatomic, strong) NSArray  <MyProblemModel *> *problems;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

#pragma mark - 额外的数据
@property (nonatomic) BOOL  expend;

@end

