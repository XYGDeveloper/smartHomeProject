//
//  LocalMineInfo.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"
/**
 本地存储的我的信息，根据接口修改而修改
 */
@class BaseMineInfoModel;
@interface LocalMineInfo : BaseObject

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *isvip;

@property (nonatomic, strong) NSNumber *todopaycount;

@property (nonatomic, strong) NSNumber *todocheckincount;

@property (nonatomic, strong) NSNumber *couponcount;

@property (nonatomic, strong) NSNumber *favoriteCount;

@property (nonatomic, copy) NSString *vipname;

@property (nonatomic, copy) NSString *discountrule;

@property (nonatomic, copy) NSString *pointsrule;

@property (nonatomic, copy) NSString *checkouttimerule;

@property (nonatomic, strong) NSNumber *points;

@property (nonatomic, strong) NSNumber *exp;

@property (nonatomic, copy) NSString *vipcode;

+(instancetype)initWithNetworkMineinfo:(BaseMineInfoModel *)networkModel;

@end
