//
//  BaseMineInfoModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>
@class VipInfoModel;
@interface BaseMineInfoModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *username;

@property (nonatomic, readonly, copy) NSString *isvip;

@property (nonatomic, readonly, strong) VipInfoModel *vipinfo;

@property (nonatomic, readonly, strong) NSNumber *todopaycount;

@property (nonatomic, readonly, strong) NSNumber *todocheckincount;

@property (nonatomic, readonly, strong) NSNumber *couponcount;

@property (nonatomic, readonly, copy) NSString *phone;

@property (nonatomic, readonly, copy) NSString *facepath;

@property (nonatomic, readonly, strong) NSNumber *favoritecount;

@property (nonatomic, readonly, copy) NSString *invitecode;

@property (nonatomic, readonly, strong) NSNumber *contactsSize;

@property (nonatomic, readonly, strong) NSNumber *points;

@property (nonatomic, readonly, copy) NSString *isSign;

@end
