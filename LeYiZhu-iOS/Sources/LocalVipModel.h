//
//  LocalVipModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/9.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VipCardMacros.h"


@interface LocalVipModel : NSObject

@property (nonatomic, assign) vipType vipType;

@property (nonatomic, assign) vipType currentVip;//用户当前vip

@property (nonatomic, strong) NSNumber *growingValue;

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, strong) NSNumber *targetGrowingValue;

@property (nonatomic, copy) NSString *discoutRule;

@property (nonatomic, copy) NSString *checkOutRule;

@property (nonatomic, copy) NSString *pointRule;

@end
