//
//  InvoiceTitleModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    enterpriseType = 0,
    governmentType,
    personalType,
} taxType;


@interface InvoiceTitleModel : NSObject

@property (nonatomic, assign) taxType type;

@property (nonatomic, copy) NSString *lookUpID;

@property (nonatomic, copy) NSString *taxTitle;

@property (nonatomic, copy) NSString *taxNum;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign) NSInteger index;

@end
