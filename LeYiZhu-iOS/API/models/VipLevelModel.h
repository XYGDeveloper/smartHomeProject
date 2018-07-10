//
//  VipLevelModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface VipLevelModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *code;//会员卡编码

@property (nonatomic, readonly, copy) NSString *name;//会员卡名称

@property (nonatomic, readonly, copy) NSString *discountrule;

@property (nonatomic, readonly, copy) NSString *pointsrule;

@property (nonatomic, readonly, copy) NSString *checkouttimerule;

@property (nonatomic, readonly, strong) NSNumber *exp;

@property (nonatomic, readonly, copy) NSString *imgUrl;//图片URL

@property (nonatomic, readonly, copy) NSString *h5Url;//网页URL

@end
