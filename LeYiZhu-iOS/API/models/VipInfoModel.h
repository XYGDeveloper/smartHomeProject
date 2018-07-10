//
//  VipInfoModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface VipInfoModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *vipname;

@property (nonatomic, readonly, copy) NSString *discountrule;

@property (nonatomic, readonly, copy) NSString *pointsrule;

@property (nonatomic, readonly, copy) NSString *checkouttimerule;

@property (nonatomic, readonly, strong) NSNumber *exp;

@property (nonatomic, readonly, copy) NSString *vipcode;

@end
