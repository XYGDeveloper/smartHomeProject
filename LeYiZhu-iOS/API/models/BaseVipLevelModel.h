//
//  BaseVipLevelModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@class VipLevelModel;
@interface BaseVipLevelModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *exp;

@property (nonatomic, readonly, copy) NSString *vipcode;

@property (nonatomic, readonly, copy) NSString *vipRulesUrl;//会员规则url

@property (nonatomic, readonly, strong) NSArray *viplevels;

@end
